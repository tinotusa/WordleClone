//
//  KeyboardView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI

struct KeyboardView: View {
    @Binding var text: String
    let onSubmit: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                KeyboardKeyRow(letters: "qwertyuiop") { letter in
                    text.append(letter)
                }
                .disabled(text.count == 5)
                Button {
                    text.removeLast()
                } label: {
                    Label("Backspace", systemImage: "delete.left")
                        .labelStyle(.iconOnly)
                }
                .disabled(text.isEmpty)
            }
            
            HStack {
                KeyboardKeyRow(letters: "asdfghjkl") { letter in
                    text.append(letter)
                }
                .disabled(text.count == 5)
                Button {
                    onSubmit()
                } label: {
                    Label("Submit", systemImage: "return")
                        .labelStyle(.iconOnly)
                }
                .disabled(text.count != 5)
            }
            
            KeyboardKeyRow(letters: "zxcvbnm") { letter in
                text.append(letter)
            }
            .disabled(text.count == 5)
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    struct ContainerView: View {
        @State private var text = ""
        
        var body: some View {
            KeyboardView(text: $text) {
                
            }
        }
    }
    
    static var previews: some View {
        ContainerView()
    }
}
