//
//  QuizViewModel.swift
//  TheMillionaireGame
//
//  Created by Валентин on 21.07.2025.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    
    @Published var fiftyHintWasUsed: Bool = false
    @Published var callHintWasUsed: Bool = false
    @Published var audienceHelpHintWasUsed: Bool = false
    
    @Published var questions: [Question] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var shouldResetTimer: Bool = false
    @Published var shouldStopTimer: Bool = false
    
    @Published var currentTextQuestion = ""
    var numberCurrentQuestion = 0
    @Published var answers = ["", "", "", ""]
    @Published var correctAnswer = ""
    var correctAnswerIndex: Int? {
        answers.firstIndex(of: correctAnswer)
    }
    var difficultQuestion: String {                 //для подсказки другу
        questions[numberCurrentQuestion].difficulty
    }
    
    // Для случая, когда пользователь забрал деньги
    @Published var tookMoneyPrize: Int? = nil
    @Published var tookMoneyQuestionNumber: Int? = nil

    @Published var timer: Timer? = nil
    @Published var priceOrHintScreenIsShown: Bool = false
    @Published var timeRemaining: Int = 30
    let totalTime: Int = 30

    func setTookMoneyPrize() {
        // номер вопроса
        let questionIndex = numberCurrentQuestion
        if questionIndex == 0 {
            tookMoneyPrize = 0
            tookMoneyQuestionNumber = 0
        } else if questionIndex > 0 && questionIndex < questionPrices.count {
            tookMoneyPrize = Int(questionPrices[questionIndex-1].currency.amount)
            tookMoneyQuestionNumber = questionIndex
        } else {
            tookMoneyPrize = nil
            tookMoneyQuestionNumber = nil
        }
    }
    func resetTookMoneyPrize() {
        tookMoneyPrize = nil
        tookMoneyQuestionNumber = nil
    }
    
    //для случая неверного ответа
    var gameOverPrize: Int {    //несгораемая сумма
        let q = numberCurrentQuestion
        if q < 5 {
            return 0
        } else if q < 10 {
            return Int(questionPrices[4].currency.amount)
        } else if q < 14 {
            return Int(questionPrices[9].currency.amount)
        } else {
            return Int(questionPrices[14].currency.amount)
        }
    }
    var gameOverPrizeQuestionNumber: Int {  //номер вопроса, соответствующий несгораемой сумме (для отображения на экране GameOver)
        let q = numberCurrentQuestion
        if q < 5 {
            return 0
        } else if q < 10 {
            return 5
        } else if q < 14 {
            return 10
        } else {
            return 15
        }
    }
    
    let timeKey = "timeKey"

    func loadQuestions() async {
        await MainActor.run { self.isLoading = true }
        await MainActor.run { self.errorMessage = nil }
        
        do {
            let questionsFromAPI = try await NetworkService.shared.fetchQuestions()
            print("от api получил \(questionsFromAPI.count) вопросов")
            if !questionsFromAPI.isEmpty {
                await MainActor.run {
                    self.questions = questionsFromAPI
                    self.isLoading = false
                }
                self.saveQuestionsToUserDefaults()
            }
            
        } catch {
            if let cachedQuestions = self.loadQuestionsFromUserDefaults() {
                if !cachedQuestions.isEmpty {
                    await MainActor.run {
                        self.questions = cachedQuestions
                        self.isLoading = false
                    }
                }
            } else {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
    
    func saveQuestionsToUserDefaults() {
        if let data = try? JSONEncoder().encode(questions) {
            UserDefaults.standard.set(data, forKey: "cachedQuestions")
            print("сохранил в UserDefaults")
        }
    }
    
    func loadQuestionsFromUserDefaults() -> [Question]? {
        print("ошибка api, загружаю из UserDefaults")
        if let data = UserDefaults.standard.data(forKey: "cachedQuestions"), let questions = try? JSONDecoder().decode([Question].self, from: data) {
            print("успешно загрузил из UserDefaults")
            return questions
        } else {
            print("загрузил из массива по умолчанию")
            return getQuestionsDefault()
        }
    }
    
    private func nextQuestion() {
        let nextIndex = numberCurrentQuestion + 1
        guard questions.indices.contains(nextIndex) else { return }
        initializeQuestion(at: nextIndex)
    }
    
    func initializeQuestion(at index: Int) {
        guard questions.indices.contains(index) else { return }
        numberCurrentQuestion = index
        currentTextQuestion = questions[numberCurrentQuestion].question.htmlDecoded
        correctAnswer = questions[numberCurrentQuestion].correctAnswer.htmlDecoded
        print("Вопрос \(numberCurrentQuestion+1). Правильный ответ: \(correctAnswer)")
        answers = ([correctAnswer] + questions[numberCurrentQuestion].incorrectAnswers.map{ $0.htmlDecoded } ).shuffled()
    }
    
    func answerTapped(_ index: Int) {
        
        shouldStopTimer = true
        
        let userAnswer = answers[index]
        
        ///надо проиграть в течение 5 секунд интригующая музыка "otvet-prinyat.mp3"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            
            if userAnswer == self.correctAnswer {
                if self.numberCurrentQuestion < 14 {
                    self.saveGameState(numberQuestion: self.numberCurrentQuestion)
                    self.nextQuestion()
                } else if self.numberCurrentQuestion == 14 {
                    self.numberCurrentQuestion = 15
                    self.saveGameState(numberQuestion: nil)
                }
            } else {
                self.saveGameState(numberQuestion: nil)
            }
            
            self.shouldStopTimer = true
        }
    }
    
    func getQuestionsDefault() -> [Question] {
        return [
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "General Knowledge",
                question: "What is \"dabbing\"?",
                correctAnswer: "A dance",
                incorrectAnswers: ["A medical procedure", "A sport", "A language"]
            ),
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "Entertainment: Video Games",
                question: "Who is the main protagonist in the game Life is Strange: Before The Storm?",
                correctAnswer: "Chloe Price ",
                incorrectAnswers: ["Max Caulfield", "Rachel Amber", "Frank Bowers"]
            ),
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "Sports",
                question: "Which boxer was banned for taking a bite out of Evander Holyfield's ear in 1997?",
                correctAnswer: "Mike Tyson",
                incorrectAnswers: ["Roy Jones Jr.", "Evander Holyfield", "Lennox Lewis"]
            ),
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "Science: Computers",
                question: "Which computer language would you associate Django framework with?",
                correctAnswer: "Python",
                incorrectAnswers: ["C#", "C++", "Java"]
            ),
            Question(
                type: "multiple",
                difficulty: "easy",
                category: "History",
                question: "The collapse of the Soviet Union took place in which year?",
                correctAnswer: "1991",
                incorrectAnswers: ["1992", "1891", "1990"]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Entertainment: Japanese Anime & Manga",
                question: "In JoJo's Bizarre Adventure, who says \"Yare yare daze\"?",
                correctAnswer: "Jotaro Kujo",
                incorrectAnswers: ["Joseph Joestar", "Jolyne Cujoh", "Koichi Hirose"]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Entertainment: Video Games",
                question: "Which company made the Japanese RPG \"Dragon Quest\"?",
                correctAnswer: "Square Enix",
                incorrectAnswers: ["Capcom", "Konami", "Blizzard"]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Entertainment: Video Games",
                question: "In the game Pokémon Conquest, how many kingdoms make up the region of Ransei?",
                correctAnswer: "17",
                incorrectAnswers: ["18", "15", "16"]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Entertainment: Video Games",
                question: "Who is the main villain of Kirby's Return to Dreamland?",
                correctAnswer: "Magolor",
                incorrectAnswers: ["Landia", "King Dedede", "Queen Sectonia "]
            ),
            Question(
                type: "multiple",
                difficulty: "medium",
                category: "Entertainment: Japanese Anime & Manga",
                question: "What year did \"Attack on Titan\" Season 2 begin airing?",
                correctAnswer: "2017",
                incorrectAnswers: ["2018", "2019", "2020"]
            ),
            Question(
                type: "multiple",
                difficulty: "hard",
                category: "General Knowledge",
                question: "Which of these cities does NOT have a United States Minting location?",
                correctAnswer: "St. Louis, MO",
                incorrectAnswers: ["San Fransisco, CA", "Philidelphia, PA", "West Point, NY"]
            ),
            Question(
                type: "multiple",
                difficulty: "hard",
                category: "Entertainment: Film",
                question: "The film Mad Max: Fury Road features the Dies Irae  from which composer's requiem?",
                correctAnswer: "Verdi",
                incorrectAnswers: ["Mozart", "Berlioz", "Brahms"]
            ),
            Question(
                type: "multiple",
                difficulty: "hard",
                category: "Science & Nature",
                question: "What does the term \"isolation\" refer to in microbiology?",
                correctAnswer: "The separation of a strain from a natural, mixed population of living microbes",
                incorrectAnswers: [
                    "A lack of nutrition in microenviroments",
                    "The nitrogen level in soil",
                    "Testing effects of certain microorganisms in an isolated enviroments, such as caves"
                ]
            ),
            Question(
                type: "multiple",
                difficulty: "hard",
                category: "Entertainment: Film",
                question: "Which actors made up the trio in \"The Good, the Bad, and the Ugly\"? ",
                correctAnswer: "Clint Eastwood, Eli Wallach, and Lee Van Cleef",
                incorrectAnswers: [
                    "Sergio Leone, Ennio Morricone, and Tonino Delli Colli",
                    "Yul Brynner, Steve McQueen, and Charles Bronson",
                    "Aldo Giuffrè, Mario Brega, and Luigi Pistilli"
                ]
            ),
            Question(
                type: "multiple",
                difficulty: "hard",
                category: "Science: Mathematics",
                question: "What is the approximate value of mathematical constant e?",
                correctAnswer: "2.72",
                incorrectAnswers: ["3.14", "1.62", "1.41"]
            )
        ]
    }
    //MARK: - Mock Data for Audience Help Button
    func generateAudienceHelpData(source: [String]) -> [AudienceOpinion] {
        var audienceHelpData: [AudienceOpinion] = []
        source.forEach { source in
            let answer = AudienceOpinion(source: source, count: Int.random(in: 0...250))
            audienceHelpData.append(answer)
        }
        return audienceHelpData
    }
    
    
    //MARK: - Change BackgroundColor in Timer
    
    func setBackground(time: Double, totalTime: Double) -> Color {
        if time <= 5 {
            return .red.opacity(0.8)
        } else if time <= totalTime / 2 {
            return .yellow.opacity(0.5)
        } else {
            return .white.opacity(0.3)
        }
    }
    
    //MARK: - UserDefaults
    
    func saveTimeRemaining(timeRemaining: Double) {
        UserDefaults.standard.set(timeRemaining, forKey: timeKey)
    }
    
    func saveGameState(numberQuestion: Int?) {
        if let number = numberQuestion {
            UserDefaults.standard.set(number, forKey: "savedCurrentQuestion")
        } else {
            UserDefaults.standard.removeObject(forKey: "savedCurrentQuestion")
        }
    }

    func loadGameState() {
        if let savedIndex = UserDefaults.standard.value(forKey: "savedCurrentQuestion") as? Int {
            self.numberCurrentQuestion = savedIndex - 1
            if !questions.isEmpty && numberCurrentQuestion < questions.count {
                self.currentTextQuestion = questions[numberCurrentQuestion].question
                self.answers = ([questions[numberCurrentQuestion].correctAnswer] + questions[numberCurrentQuestion].incorrectAnswers).shuffled()
            } else {
                // todo тут типа надо загрузить вопросы
            }
        }
    }
    
    func updateBestScoreIfNeeded() {
        let currentResult: Int
            if let tookPrize = tookMoneyPrize {
                currentResult = tookPrize
            } else {
                currentResult = gameOverPrize
            }
            let bestScoreKey = "bestScore"
            let previousBest = UserDefaults.standard.integer(forKey: bestScoreKey)
            if currentResult > previousBest {
                UserDefaults.standard.set(currentResult, forKey: bestScoreKey)
            }
    }
    
    //MARK: - Work with Timer
    
    func timeExpired() {
        saveGameState(numberQuestion: nil)
    }

    
    func startTimer() {
        // Останавливаем предыдущий таймер, если был
        stopTimer()
        
        // Устанавливаем начальное время
        timeRemaining = totalTime
        
        // Запускаем новый таймер
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stopTimer()
                self.timeExpired()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
