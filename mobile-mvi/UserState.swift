//
//  TrackState.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

enum UserState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case changingName(String)
    case error
    case loadingUsers
    case loadedUsers([UserDTO])
    //var description: String{ ... }
    
    //static func == (lhs: Self, rhs: Self) -> Bool {
    //    return lhs.case == rhs.case
    //}
}

