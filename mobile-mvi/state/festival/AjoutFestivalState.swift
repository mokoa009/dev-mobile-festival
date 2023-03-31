//
//  AjoutFestivalState.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation

enum AjoutFestivalState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case addingFestival(FestivalDTO)
    case added
}
