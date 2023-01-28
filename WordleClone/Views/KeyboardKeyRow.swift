//
//  KeyboardKeyRow.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct KeyboardKeyRow: View {
    private let letters: String
    private let action: (Character) -> Void
    private let usedLetters: [UsedLetter]
    
    init(letters: String, usedLetters: [UsedLetter], action: @escaping (Character) -> Void) {
        self.letters = letters
        self.action = action
        self.usedLetters = usedLetters
    }
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(Array(letters), id: \.self) { letter in
                Button {
                    action(letter)
                } label: {
                    Text(String(letter))
                        .foregroundColor(.white)
                        .frame(width: 30, height: 40)
                        .background(backgroundColour(keyboardLetter: letter))
                        .cornerRadius(10)
                }
            }
        }
    }
}

private extension KeyboardKeyRow {
    func backgroundColour(keyboardLetter: Character) -> Color {
        if !usedLetters.map(\.letter).contains(keyboardLetter) {
            return .blue
        }
        let index = usedLetters.map(\.letter).firstIndex(of: keyboardLetter)
        switch usedLetters[index!].location {
        case .correct: return .green
        case .incorrect: return .orange
        case .notInSecret: return .gray
        }
    }
}

struct KeyboardKeyRow_Previews: PreviewProvider {
    static let secretWord = "shock"
    static var previews: some View {
        KeyboardKeyRow(letters: "qwertyuiop", usedLetters: []) { letter in
            
        }
    }
}
