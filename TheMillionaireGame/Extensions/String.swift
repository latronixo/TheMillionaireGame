//
//  String.swift
//  TheMillionaireGame
//
//  Created by Валентин on 22.07.2025.
//

import Foundation

//данное расширение нужно для случая, когда мы имеем вопрос
//Question(
//type: "multiple",
//difficulty: "easy",
//category: "General Knowledge",
//question: "What is \"dabbing\"?",
//correctAnswer: "A dance",
//incorrectAnswers: ["A medical procedure", "A sport", "A language"]
//),
//
//и мы хотим увидеть на экране вопрос What is "dabbing"
//а вместо этого мы видим What is &quot;dabbing&quot;?
extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            return attributedString.string
        }
        return self
    }
}
