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
                    ForEach(0 ..< 5) { _ in
                        WordInputView(word: "")
                    }
                }
                
                VStack {
                    ForEach(viewModel.words, id: \.self) { word in
                        SubmittedWordView(wordInput: word, correctWord: viewModel.secretWord)
                    }
                    WordInputView(word: viewModel.currentWord)
                }
            }
            
            Spacer()
            if viewModel.gameIsOver {
                Button("Restart") {
                    viewModel.resetGame()
                }
            }
            KeyboardView(text: $viewModel.currentWord) {
                viewModel.addWord()
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
