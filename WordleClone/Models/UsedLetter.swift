//
//  UsedLetter.swift
//  WordleClone
//
//  Created by Tino on 28/1/2023.
//

import SwiftUI

/// A letter that has already been entered.
struct UsedLetter: Hashable, Identifiable {
    /// The location of the letter based on the secret word.
    enum LetterLocation {
        /// The letter is in the correct location.
        case correct
        /// The letter is in the word but wrong location.
        case incorrect
        /// The letter is not in the secret word.
        case notInSecret
        
        var colour: Color {
            switch self {
            case .correct: return .green
            case .incorrect: return .orange
            case .notInSecret: return .gray
            }
        }
    }
    
    /// The used letter.
    var letter: Character
    /// The location of the used letter.
    var location: LetterLocation
    /// The id of the letter
    let id = UUID()
}
