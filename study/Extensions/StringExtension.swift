//
//  StringExtension.swift
//  study
//
//  Created by Dursun YILDIZ on 1.08.2023.
//

import Foundation
extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
}
