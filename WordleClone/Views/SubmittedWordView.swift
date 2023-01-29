//
//  SubmittedWordView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct SubmittedWordView: View {
    let usedLetters: [UsedLetter]
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            ForEach(Array(usedLetters.enumerated()), id: \.offset) { index, letter in
                BoxedLetterView(letter: letter.letter, backgroundColour: letter.location.colour)
                    .rotation3DEffect(.degrees(isAnimating ? 360 : 180), axis: (x: 0, y: 1, z: 0))
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.rotate(index: index), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

struct SubmittedWordView_Previews: PreviewProvider {
    static let wordInput = "tests"
    static let correctWord = "shock"
    static func letterLocation(index: Int, letter: Character, correctWord: String) -> UsedLetter.LetterLocation {
        let correctWord = Array(correctWord)
        if correctWord[index] == letter {
            return .correct
        }
        if correctWord.contains(letter) {
            return .incorrect
        }
        return .notInSecret
    }
    
    static var previews: some View {
        VStack {
            SubmittedWordView(
                usedLetters: "testi".enumerated().map {
                    UsedLetter(
                        letter: $0.element,
                        location: letterLocation(index: $0.offset, letter: $0.element, correctWord: correctWord)
                    )
                }
            )
            SubmittedWordView(
                usedLetters: "howdy".enumerated().map {
                    UsedLetter(
                        letter: $0.element,
                        location: letterLocation(index: $0.offset, letter: $0.element, correctWord: correctWord)
                    )
                }
            )
            SubmittedWordView(
                usedLetters: "quake".enumerated().map {
                    UsedLetter(
                        letter: $0.element,
                        location: letterLocation(index: $0.offset, letter: $0.element, correctWord: correctWord)
                    )
                }
            )
            SubmittedWordView(
                usedLetters: "shock".enumerated().map {
                    UsedLetter(
                        letter: $0.element,
                        location: letterLocation(index: $0.offset, letter: $0.element, correctWord: correctWord)
                    )
                }
            )
        }
    }
}
