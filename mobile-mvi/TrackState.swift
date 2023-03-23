//
//  TrackState.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

enum TrackState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case changingName(String)
    case error
    case loadingUsers
    //var description: String{ ... }
    
    //static func == (lhs: Self, rhs: Self) -> Bool {
    //    return lhs.case == rhs.case
    //}
}

