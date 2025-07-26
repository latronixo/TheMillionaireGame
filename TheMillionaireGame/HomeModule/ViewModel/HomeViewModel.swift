//
//  HomeView.swift
//  TheMillionaireGame
//
//  Created by Mika on 24.07.2025.
//


import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var bestScore: Int?
    @Published var hasUnfinishedGame: Bool = false
    @Published var showRulesSheet: Bool = false
    @Published var showGameView: Bool = false
    @Published var isGameOverView: Bool = false
    @Published var winAmount: Int?
    @Published var savedGameViewModel: QuizViewModel?
    @Published var quizViewModel: QuizViewModel = QuizViewModel()
    
    
    let level: Int?
    
    
    
    
    // todo - надо передавать еще сумму выигрыша winAmount
    
    init(level: Int? = nil) {
        
        self.level = level
        
        loadSavedGame()
        
        //mock
        if level != nil {
            winAmount = 1000
        }
        //
        
        loadData()
    }
    
    func loadSavedGame() {
        if let savedIndexQuestion = UserDefaults.standard.value(forKey: "savedCurrentQuestion") as? Int {
            let vm = QuizViewModel()
            self.savedGameViewModel = vm
            Task {
                await vm.loadQuestions()
                await MainActor.run {
                    vm.initializeQuestion(at: savedIndexQuestion)
                }
            }
        } else {
            self.savedGameViewModel = nil
        }
    }
    
    func loadData() {
        self.isGameOverView = level != nil // todo
        
        self.bestScore = HomeModel.loadBestScore()
        
        //mock
        continueGame()
        //
        
        self.hasUnfinishedGame = savedGameViewModel != nil
    }
    
    func startNewGame() {
        let newQuizViewModel = QuizViewModel()
        self.savedGameViewModel = newQuizViewModel
        Task {
            await newQuizViewModel.loadQuestions()
            await MainActor.run {
                newQuizViewModel.initializeQuestion(at: 0)
            }
        }
    }
    
    func continueGame() {
        if let savedIndexQuestion = UserDefaults.standard.value(forKey: "savedCurrentQuestion") as? Int {
            let vm = QuizViewModel()
            self.savedGameViewModel = vm
            Task {
                await vm.loadQuestions()
                await MainActor.run {
                    vm.initializeQuestion(at: savedIndexQuestion)
                }
            }
        }
    }
}
