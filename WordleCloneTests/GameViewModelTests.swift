//
//  GameViewModelTests.swift
//  WordleCloneTests
//
//  Created by Tino on 30/1/2023.
//

import XCTest
@testable import WordleClone

final class GameViewModelTests: XCTestCase {
    var viewModel: GameViewModel!
    
    override func setUpWithError() throws {
        viewModel = GameViewModel()
    }
    
    func testAddWordWithEmptyCurrentWord() {
        // current word is not set
        viewModel.addWord()
        XCTAssertTrue(viewModel.usedWordLetters.isEmpty, "Expected the used word letter array to be empty")
    }
    
    func testAddWordWithWordThatExceedsLimit() {
        viewModel.currentWord = "daskjlfdsjfasdfj"
        viewModel.addWord()
        XCTAssertTrue(viewModel.usedWordLetters.isEmpty)
    }
    
    func testAddWordSuccessfully() {
        viewModel.currentWord = "asdfg"
        viewModel.addWord()
        XCTAssertEqual(viewModel.usedWordLetters.count, 1)
    }
    
    func testResetGame() {
        viewModel.currentWord = "testi"
        viewModel.addWord()
        XCTAssertEqual(viewModel.usedLetters.count, 4, "Expected the used letters count to be 4.")
        viewModel.currentWord = "shock"
        viewModel.addWord()
        XCTAssertEqual(viewModel.usedWordLetters.count, 2,  "Expected the usedWordLetters count to be 2.")
        XCTAssertTrue(viewModel.gameIsOver, "Expected the game to be over since the secret word was found.")
        
        viewModel.resetGame()
        
        XCTAssertTrue(viewModel.currentWord.isEmpty, "Expected the current word to be empty after calling resetGame")
        XCTAssertTrue(viewModel.usedLetters.isEmpty, "Expected the usedLetters to be empty after calling resetGame")
        XCTAssertTrue(viewModel.usedWordLetters.isEmpty, "Expected usedWordLetters to be empty after calling resetGame")
        XCTAssertFalse(viewModel.gameIsOver, "Expected the gameIsOver to be false after calling resetGame")
    }
}
