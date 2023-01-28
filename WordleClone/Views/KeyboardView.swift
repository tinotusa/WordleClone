//
//  KeyboardView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct KeyboardView: View {
    @Binding private var text: String
    private let usedLetters: [UsedLetter]
    private let onSubmit: () -> Void
    
    init(text: Binding<String>, usedLetters: [UsedLetter], onSubmit: @escaping () -> Void) {
        _text = text
        self.usedLetters = usedLetters
        self.onSubmit =  onSubmit
    }
    
    var body: some View {
        VStack {
            ForEach(KeyboardRow.allCases) { keyboardRow in
                HStack {
                    KeyboardKeyRow(letters: keyboardRow.keys, usedLetters: usedLetters) { letter in
                        text.append(letter)
                    }
                    .disabled(text.count == 5)
                    
                    if keyboardRow == .qwerRow {
                        backspaceButton
                    }
                    
                    if keyboardRow == .asdfRow {
                        submitButton
                    }
                }
            }
        }
    }
}

private extension KeyboardView {
    var backspaceButton: some View {
        Button {
            text.removeLast()
        } label: {
            Label("Backspace", systemImage: "delete.left")
                .labelStyle(.iconOnly)
        }
        .disabled(text.isEmpty)
    }
    
    var submitButton: some View {
        Button {
            onSubmit()
        } label: {
            Label("Submit", systemImage: "return")
                .labelStyle(.iconOnly)
        }
        .disabled(text.count != 5)
    }
}

struct KeyboardView_Previews: PreviewProvider {
    struct ContainerView: View {
        @State private var text = ""
        
        var body: some View {
            KeyboardView(text: $text, usedLetters: []) {
                
            }
        }
    }
    
    static var previews: some View {
        ContainerView()
    }
}
