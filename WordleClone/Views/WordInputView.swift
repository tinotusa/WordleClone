//
//  WordInputView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct WordInputView: View {
    let word: String
    let emptySpaces: String
    
    init(word: String) {
        self.word = word
        let remainingSpots = 5 - word.count
        emptySpaces = String(repeating: " ", count: remainingSpots)
    }
    
    var body: some View {
        HStack {
            ForEach(Array(word)) { letter in
                Text(String(letter))
                    .frame(width: 40, height: 40)
                    .background(.white)
                    .foregroundColor(.black)
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.gray)
                    }
            }
            
            ForEach(Array(emptySpaces)) { space in
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.gray)
                    .frame(width: 40, height: 40)
            }
        }
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
