//
//  GameViewModel.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import Foundation
import os

final class GameViewModel: ObservableObject {
    @Published var currentWord = ""
    @Published var words = [String]()
    @Published var usedLetters = Set<UsedLetter>()
    @Published var gameIsOver = false
    private(set) var secretWord = "shock"
    
    private let log = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: GameViewModel.self)
    )
}

extension GameViewModel {
    /// Adds a word to the list of words and checks
    /// to see if the word is correct
    func addWord() {
        log.log("Adding word: \(self.currentWord)")
        if currentWord.count < 5 {
            log.log("Failed to add word. Invalid word count")
            return
        }
        words.append(currentWord)
        let secretWordArray = Array(secretWord)
        currentWord.enumerated().forEach { index, letter in
            var location = UsedLetter.LetterLocation.notInSecret
            if letter == secretWordArray[index] {
                location = .correct
            } else if secretWord.contains(letter) {
                location = .incorrect
            } else {
                location = .notInSecret
            }
            let seenLetters = usedLetters.filter { $0.letter == letter }
            seenLetters.forEach { usedLetters.remove($0) }
            
            usedLetters.insert(.init(letter: letter, location: location))
        }
        if currentWord == secretWord {
            gameIsOver = true
        }
        currentWord = ""
        log.log("Successfully added word \(self.currentWord) to words array.")
    }
    
    /// Resets the state of the game back to the starting point.
    func resetGame() {
        log.log("Reseting the game.")
        currentWord = ""
        words = []
        gameIsOver = false
        secretWord = "shock" // TODO: get other words
        usedLetters = []
    }
}
