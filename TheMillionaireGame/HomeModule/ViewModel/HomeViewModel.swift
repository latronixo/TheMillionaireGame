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

    
    let level: Int?
    
    
    
    
    // todo - надо передавать еще сумму выигрыша winAmount
    
    init(level: Int? = nil) {
        
        self.level = level
        
        //mock
        if level != nil {
            winAmount = 1000
        }
        //
        
        loadData()
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
        self.showGameView = true
    }
    
    func continueGame() {
        self.savedGameViewModel = HomeModel.loadSavedGame()
        self.hasUnfinishedGame = savedGameViewModel != nil
    }
}
