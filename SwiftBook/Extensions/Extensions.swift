//
//  Extensions.swift
//  SwiftBook
//
//  Created by Yuri on 06.02.2023.
//

import Foundation

/// Method for getting all keys with same values:
/// - Parameter value: Value to get all keys
extension Dictionary where Value: Equatable {
    func keysForVlue(value: Value) -> [Key] {
        return compactMap {
            (key: Key, value_: Value) -> Key? in value == value_ ? key : nil
        }
    }
}
