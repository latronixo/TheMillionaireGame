//
//  QuestionPrice.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 22.07.2025.
//

import Foundation

struct QuestionPrice: Hashable, Codable, Identifiable {
    var id: Int
    var difficulty: String
    var currency: Currency
}


struct Currency: Hashable, Codable {
    var code: String
    var amount: Double
}
