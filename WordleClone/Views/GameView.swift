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
            ZStack (alignment: .top) {
                VStack {
                    ForEach(0 ..< GameViewModel.maxSecretWordLetterCount, id: \.self) { _ in
                        WordInputView(word: "")
                    }
                }
                
                VStack {
                    ForEach(viewModel.usedWordLetters, id: \.self) { word in
                        SubmittedWordView(usedLetters: word)
                    }
                    WordInputView(word: viewModel.currentWord)
                }
            }
            
            Spacer()
            if viewModel.gameIsOver {
                Button("Restart") {
                    viewModel.resetGame()
                }
                .buttonStyle(.borderedProminent)
            }
            KeyboardView(text: $viewModel.currentWord, usedLetters: Array(viewModel.usedLetters)) {
                viewModel.addWord()
            }
            .disabled(viewModel.gameIsOver)
        }
        .padding()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
