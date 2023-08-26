//
//  Optional+.swift
//  MovieList_Viper
//
//  Created by Sezgin Çiftci on 26.08.2023.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self == "" || self == nil
    }
}
