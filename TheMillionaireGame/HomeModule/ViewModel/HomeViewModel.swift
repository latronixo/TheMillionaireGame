import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var bestScore: Int?
    @Published var hasUnfinishedGame: Bool = false
    @Published var showRulesSheet: Bool = false
    @Published var showGameView: Bool = false
    @Published var isGameOverView: Bool = false
    @Published var winAmount: Int?
    
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
        self.isGameOverView = (level == nil ? false : true)
        self.bestScore = HomeModel.loadBestScore()
        self.hasUnfinishedGame = HomeModel.hasUnfinishedGame()
    }
    
    func startNewGame() {
        self.showGameView = true
    }
    
    func continueGame() {
       //
    }
    
    //check it
    func showRules() {
        self.showRulesSheet.toggle()
    }
}
