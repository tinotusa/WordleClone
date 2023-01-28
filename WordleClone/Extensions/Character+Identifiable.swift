//
//  Character+Identifiable.swift
//  WordleClone
//
//  Created by Tino on 28/1/2023.
//

import Foundation

extension Character: Identifiable {
    public var id: UInt8 {
        self.asciiValue!
    }
}
