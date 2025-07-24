//
//  QuizViewModel.swift
//  TheMillionaireGame
//
//  Created by Валентин on 21.07.2025.
//

import SwiftUI

final class QuizViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    
    @Published var currentTextQuestion = ""
    var numberCurrentQuestion = 1
    @Published var answers = ["", "", "", ""]
    @Published var correctAnswer = ""
    var difficultQuestion: String {                 //для подсказки другу
        questions[numberCurrentQuestion].difficulty
    }
    @Published var showPriceList = false
    @Published var isGameOver = false
    
    
    let ABCD = ["A: ", "B: ", "C: ", "D: "]
    
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
                    self.nextQuestion()
                    self.isLoading = false
                }
                self.saveQuestionsToUserDefaults()
            }
            
        } catch {
            if let cachedQuestions = self.loadQuestionsFromUserDefaults() {
                if !cachedQuestions.isEmpty {
                    await MainActor.run {
                        self.questions = cachedQuestions
                        self.nextQuestion()
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
        guard numberCurrentQuestion + 1 < questions.count else { return }
        numberCurrentQuestion += 1
        currentTextQuestion = questions[numberCurrentQuestion].question.htmlDecoded //кавычки API останутся кавычками, а не &quot;
        correctAnswer = questions[numberCurrentQuestion].correctAnswer.htmlDecoded //кавычки API останутся кавычками, а не &quot;
        print("Вопрос \(numberCurrentQuestion). Правильный ответ: \(correctAnswer)")
        answers = ([correctAnswer] + questions[numberCurrentQuestion].incorrectAnswers.map{ $0.htmlDecoded } ).shuffled() //кавычки API останутся кавычками, а не &quot;
    }
    
    func answerTapped(_ index: Int) {
        let userAnswer = answers[index]
        
        ///надо проиграть в течение 5 секунд интригующая музыка "otvet-prinyat.mp3"
        
        ///надо остановить таймер
        
        //спустя 5 секунд
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            //let isAnswerRight = userAnswer == self.correctAnswer
            
            if userAnswer == self.correctAnswer {
                ///надо чтобы выбранный ответ мигал зеленым в течение 3 секунд
                
                //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                ///надо чтобы кнопка мигала зеленым в течение 3 секунд
                //}
                
                //показываем PriceListView через 3 секунды
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.showPriceList = true
                    
                    //через 3 секунды закрываем PriceListView
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.showPriceList = false
                        self.nextQuestion()
                    }
                }
                
                print("Правильный ответ")
            } else {
                ///надо чтобы выбранный ответ мигал красным в течение 3 секунд
                
                //DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                ///надо чтобы кнопка мигала красным в течение 3 секунд
                //}
                
                //показываем isGameOver через 3 секунды
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isGameOver = true
                }
                
                print("Неправильный ответ")
                
            }
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
}
