//
//  GameViewModel.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI
import os

/// View model for `GameView`.
final class GameViewModel: ObservableObject {
    /// The current word input.
    @Published var currentWord = ""
    /// An array of the submitted words as `UsedLetter`
    @Published private(set) var usedWordLetters = [[UsedLetter]]()
    /// An array of the letters the user has already used.
    @Published private(set) var usedLetters = Set<UsedLetter>()
    /// A boolean value indicating whether the game is over.
    @Published private(set) var gameIsOver = false
    /// The previously used secret word.
    private var previousWords: Set<String> = []
    /// The word the user is trying to guess.
    @Published private(set) var secretWord = ""
    /// The max length of the `secretWord`.
    private(set) static var maxSecretWordLetterCount = 5
    /// The number of attempts the user has.
    private(set) var attemptsLeft = GameViewModel.maxSecretWordLetterCount
    /// A boolean value indicating whether the user has guessed the word.
    @Published private(set) var userGuessedWord = false
    /// A boolean value indicating whether the word entered is in the dictionary.
    @Published var wordIsInDictionary = true
    /// The text checker for the users word inputs.
    private var textChecker = UITextChecker()
    /// All the words available.
    private var words = Set<String>()
    
    private let log = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: GameViewModel.self)
    )
    
    init() {
        getWords()
        getSecretWord()
    }
}

extension GameViewModel {
    var hasAttemptsLeft: Bool {
        attemptsLeft != 0
    }
    /// Adds a word to the list of words and checks
    /// to see if the word is correct
    func addWord() {
        log.log("Adding word: \(self.currentWord)")
        if currentWord.count != Self.maxSecretWordLetterCount {
            log.log("Failed to add word. Invalid word count")
            return
        }
        guard let range = currentWord.range(of: currentWord) else {
            log.error("Failed to get range of word.")
            return
        }
        let misspellRange = textChecker.rangeOfMisspelledWord(
            in: currentWord,
            range: NSRange(range, in: currentWord),
            startingAt: 0,
            wrap: false,
            language: Locale.current.language.languageCode?.identifier ?? "en"
        )
        if misspellRange.location != NSNotFound {
            log.log("\(self.currentWord) is not a valid word.")
            withAnimation {
                wordIsInDictionary = false
            }
            return
        }
        attemptsLeft -= 1
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
        
        if attemptsLeft <= 0 {
            userGuessedWord = false
            gameIsOver = true
            log.log("Game is over user didn't guess the word in time.")
        } else if currentWord == secretWord {
            gameIsOver = true
            log.log("Game is over user guess the word.")
        } else {
            currentWord = ""
            log.log("Successfully added word \(self.currentWord) to words array.")
        }
    }
    
    /// Resets the state of the game back to the starting point.
    func resetGame() {
        log.log("Reseting the game.")
        currentWord = ""
        gameIsOver = false
        secretWord = ""
        getSecretWord()
        usedLetters = []
        usedWordLetters = []
        attemptsLeft = Self.maxSecretWordLetterCount
    }
}

// MARK: - Private functions
private extension GameViewModel {
    /// Gets all the words from file.
    private func getWords() {
        guard let url = Bundle.main.url(forResource: "allWords", withExtension: "txt") else {
            log.error("Failed to open allWords.txt")
            return
        }
        
        do {
            let words = try String(contentsOf: url).split(separator: "\n")
            self.words = Set(words.map(String.init))
            log.log("Successfully got words. \(self.words.count) words set.")
        } catch {
            log.error("Failed to get words. \(error)")
        }
    }

    /// Sets a secretWord to a new word.
    func getSecretWord() {
        log.log("Getting random word.")
        var randomWord = ""
        repeat {
            randomWord = String(words.randomElement()!)
        } while previousWords.contains(randomWord)
        previousWords.insert(secretWord)
        secretWord = randomWord
    }

    /// Gets the UsedLetters for the given word
    /// - Parameter currentWord: The string to get the used letter from.
    /// - Returns: An array of `UsedLetter`.
    func usedLetters(for currentWord: String) -> [UsedLetter] {
        log.log("Getting used letters for word: \(currentWord)")
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
}
