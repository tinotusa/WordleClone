//
//  KeyboardKeyRow.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

extension Character: Identifiable {
    public var id: UInt8 {
        self.asciiValue!
    }
}

struct KeyboardKeyRow: View {
    let letters: [Character]
    let action: (Character) -> Void
    
    init(letters: String, action: @escaping (Character) -> Void) {
        self.letters = Array(letters)
        self.action = action
    }
    
    var body: some View {
        HStack(spacing: 2) {
            ForEach(letters) { letter in
                KeyboardButton(letter: letter) { letter in
                    action(letter)
                }
            }
        }
    }
}

struct KeyboardKeyRow_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardKeyRow(letters: "qwertyuiop") { letter in
            
        }
    }
}
