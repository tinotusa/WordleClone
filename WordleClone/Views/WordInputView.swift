//
//  WordInputView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct WordInputView: View {
    private let word: String
    private let emptySpaces: Int
    
    init(word: String) {
        self.word = word
        emptySpaces = GameViewModel.maxSecretWordLetterCount - word.count
    }
    
    var body: some View {
        HStack {
            ForEach(Array(word.enumerated()), id: \.offset) { _, letter in
                BoxedLetterView(
                    letter: letter,
                    foregroundColour: .black,
                    backgroundColour: .white
                )
                .overlay {
                    roundedRectangle
                }
            }
            
            ForEach(0 ..< emptySpaces, id: \.self) { _ in
                roundedRectangle
            }
        }
    }
}

private extension WordInputView {
    var roundedRectangle: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(lineWidth: 2)
            .foregroundColor(.gray)
            .frame(width: Constants.letterWidth, height: Constants.letterHeight)
    }
}

struct WordInputView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WordInputView(word: "testi")
            WordInputView(word: "")
            WordInputView(word: "x")
        }
    }
}
