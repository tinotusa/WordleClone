//
//  SubmittedWordView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct SubmittedWordView: View {
    private let wordInput: String
    private let correctWord: [Character]
    
    init(wordInput: String, correctWord: String) {
        self.wordInput = wordInput
        self.correctWord = Array(correctWord)
    }
    
    var body: some View {
        HStack {
            ForEach(Array(wordInput.enumerated()), id: \.offset) { index, letter in
                Text(String(letter))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(backgroundColour(for: index, letter: letter))
                    .cornerRadius(10)
            }
        }
    }
    
    func backgroundColour(for index: Int, letter: Character) -> Color {
        if correctWord[index] == letter {
            return .green
        }
        if correctWord.contains(letter) {
            return .yellow
        }
        return .gray
    }
}

struct SubmittedWordView_Previews: PreviewProvider {
    static let wordInput = "tests"
    static let correctWord = "shock"
    
    static var previews: some View {
        VStack {
            SubmittedWordView(wordInput: "testi", correctWord: correctWord)
            SubmittedWordView(wordInput: "howdy", correctWord: correctWord)
            SubmittedWordView(wordInput: "quake", correctWord: correctWord)
            SubmittedWordView(wordInput: "shock", correctWord: correctWord)
        }
    }
}
