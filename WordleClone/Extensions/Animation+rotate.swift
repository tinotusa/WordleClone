//
//  Animation+rotate.swift
//  WordleClone
//
//  Created by Tino on 29/1/2023.
//

import SwiftUI

extension Animation {
    /// Rotates a view and delays it based on the index.
    /// - Parameter index: The index of the view.
    /// - Returns: An easeOut animation delayed by the index.
    static func rotate(index: Int) -> Animation {
        .easeOut
        .delay(0.09 * Double(index))
    }
}
