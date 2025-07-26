//
//  HomeModel.swift
//  TheMillionaireGame
//
//  Created by Mika on 23.07.2025.
//

import Foundation

struct HomeModel {
    private static let bestScoreKey = "bestScoreKey"
    private static let savedGameKey = "savedGameKey"
    
    
    static func loadBestScore() -> Int? {
        //todo
        // тут брать из UserDefailts bestScore
        
        //mock
        UserDefaults.standard.set(100500, forKey: bestScoreKey)
        //
        
        let value = UserDefaults.standard.value(forKey: bestScoreKey) as? Int
        return value
    }
    
    static func loadSavedGame() -> QuizViewModel? {
        // todo
        // тут восстанавливать вью модель или как-то иначе восстанавливать стейт игры
        
        //mock
        
        if UserDefaults.standard.value(forKey: "savedCurrentQuestion") is Int {
            return QuizViewModel()
        }
        return nil
    }
    
}
