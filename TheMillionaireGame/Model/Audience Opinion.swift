//
//  Audience Opinion.swift
//  TheMillionaireGame
//
//  Created by Mikhail Ustyantsev on 25.07.2025.
//

import Foundation

struct AudienceOpinion: Identifiable, Equatable {
    var id = UUID()
    var source: String
    var count: Int
}
