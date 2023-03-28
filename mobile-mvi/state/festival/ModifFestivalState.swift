//
//  ModifFestivalState.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation

enum ModifFestivalState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case updateFestival
    case updated
    case loadFestival
    case loadedFestival(Festival)
}
