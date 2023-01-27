//
//  ContentView.swift
//  WordleClone
//
//  Created by Tino on 27/1/2023.
//

import SwiftUI
let words = [
    "quiet",
    "acorn",
    "chuck",
    "trick",
    "allow",
]

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
