//
//  GameView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Wordle!")
                .font(.title)
            
            ForEach(viewModel.usedWordLetters, id: \.self) { word in
                SubmittedWordView(usedLetters: word)
            }
            
            if viewModel.hasAttemptsLeft {
                WordInputView(word: viewModel.currentWord)
                ForEach(0 ..< viewModel.attemptsLeft - 1, id: \.self) { _ in
                    WordInputView(word: "")
                }
            }
            
            
            Spacer()
            
            if viewModel.gameIsOver {
                if !viewModel.userGuessedWord {
                    Text("The word was: \(viewModel.secretWord).")
                } else {
                    Text("You got it!")
                }
                Button("Restart") {
                    viewModel.resetGame()
                }
                .buttonStyle(.borderedProminent)
            }
            
            if !viewModel.wordIsInDictionary {
                Text(#""\#(viewModel.currentWord)" is not a word."#)
            }
            
            KeyboardView(text: $viewModel.currentWord, usedLetters: Array(viewModel.usedLetters)) {
                viewModel.addWord()
            }
            .disabled(viewModel.gameIsOver)
            .onChange(of: viewModel.currentWord) { _ in
                viewModel.wordIsInDictionary = true
            }
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
