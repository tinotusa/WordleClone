//
//  BoxedLetterView.swift
//  WordleClone
//
//  Created by Tino on 29/1/2023.
//

import SwiftUI

struct BoxedLetterView: View {
    private let letter: Character
    private let foregroundColour: Color
    private let backgroundColour: Color
    
    init(letter: Character, foregroundColour: Color = .white, backgroundColour: Color) {
        self.letter = letter
        self.foregroundColour = foregroundColour
        self.backgroundColour = backgroundColour
    }
    
    var body: some View {
        Text(String(letter))
            .foregroundColor(foregroundColour)
            .frame(width: Constants.letterWidth, height: Constants.letterHeight)
            .background(backgroundColour)
            .cornerRadius(Constants.cornerRadius)
    }
}


struct BoxedLetterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BoxedLetterView(letter: "a", backgroundColour: .blue)
            BoxedLetterView(letter: "b", backgroundColour: .green)
            BoxedLetterView(letter: "c", backgroundColour: .yellow)
            BoxedLetterView(letter: "d", backgroundColour: .gray)
        }
    }
}
