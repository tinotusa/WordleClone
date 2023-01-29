//
//  GameViewModel.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import Foundation
import os

/// View model for `GameView`.
final class GameViewModel: ObservableObject {
    @Published var currentWord = ""
    @Published private(set) var usedWordLetters = [[UsedLetter]]()
    @Published private(set) var usedLetters = Set<UsedLetter>()
    @Published private(set) var gameIsOver = false
    
    private(set) var secretWord = "shock"
    private(set) static var maxSecretWordLetterCount = 5
    
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
        if currentWord.count < Self.maxSecretWordLetterCount {
            log.log("Failed to add word. Invalid word count")
            return
        }

        usedWordLetters.append(usedLetters(for: currentWord))
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
    
    /// Gets the UsedLetters for the given word
    /// - Parameter currentWord: The string to get the used letter from.
    /// - Returns: An array of `UsedLetter`.
    func usedLetters(for currentWord: String) -> [UsedLetter] {
        var usedLetters = [UsedLetter]()
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
            usedLetters.append(.init(letter: letter, location: location))
        }
        return usedLetters
    }
    
    /// Resets the state of the game back to the starting point.
    func resetGame() {
        log.log("Reseting the game.")
        currentWord = ""
        gameIsOver = false
        secretWord = "shock" // TODO: get other words
        usedLetters = []
    }
}
