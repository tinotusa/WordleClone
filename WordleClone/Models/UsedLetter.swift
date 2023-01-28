//
//  UsedLetter.swift
//  WordleClone
//
//  Created by Tino on 28/1/2023.
//

import Foundation

/// A letter that has already been entered.
struct UsedLetter: Hashable {
    /// The location of the letter based on the secret word.
    enum LetterLocation {
        /// The letter is in the correct location.
        case correct
        /// The letter is in the word but wrong location.
        case incorrect
        /// The letter is not in the secret word.
        case notInSecret
    }
    
    /// The used letter.
    var letter: Character
    /// The location of the used letter.
    var location: LetterLocation
}
