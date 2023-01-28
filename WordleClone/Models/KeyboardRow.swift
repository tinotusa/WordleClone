//
//  KeyboardRow.swift
//  WordleClone
//
//  Created by Tino on 28/1/2023.
//

import Foundation

/// Represents the rows of a keyboard.
enum KeyboardRow: CaseIterable, Identifiable {
    case qwerRow
    case asdfRow
    case zxcvRow
    
    /// A unique id for a case.
    var id: Self { self }
    
    /// The keys that a row has.
    var keys: String {
        switch self {
        case .qwerRow: return "qwertyuiop"
        case .asdfRow: return "asdfghjkl"
        case .zxcvRow: return "zxcvbnm"
        }
    }
}
