//
//  FestivalState.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import Foundation

enum FestivalState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case changingName(String)
    case error
    case loadingFestivals
    case loadedFestivals([FestivalDTO])
    //var description: String{ ... }
    
    //static func == (lhs: Self, rhs: Self) -> Bool {
    //    return lhs.case == rhs.case
    //}
}
