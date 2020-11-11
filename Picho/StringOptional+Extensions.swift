//
//  StringOptional+Extensions.swift
//  Picho
//
//  Created by Windy on 11/11/20.
//

import UIKit

extension Optional where Wrapped == String {
    func convertToDouble() -> Double {
        return Double(self ?? "0.0") ?? 0.0
    }
}
