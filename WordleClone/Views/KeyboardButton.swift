//
//  KeyboardButton.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct KeyboardButton: View {
    let letter: Character
    let action: (Character) -> Void
    
    var body: some View {
        Button {
            action(letter)
        } label: {
            Text("\(String(letter))")
                .foregroundColor(.white)
                .frame(width: 30, height: 40)
                .background(.secondary)
                .cornerRadius(10)
        }
    }
}

struct KeyboardButton_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardButton(letter: "a") { letter in
            
        }
    }
}
