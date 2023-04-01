//
//  UserNonAffecteState.swift
//  mobile-mvi
//
//  Created by garcy on 29/03/2023.
//

import Foundation


enum UserNonAffecteState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case loadingUsers
    case loadedUsers([UserDTO])
    case affectingBenevole
    case benevoleAffected(UserViewModel)
    //var description: String{ ... }
    
    //static func == (lhs: Self, rhs: Self) -> Bool {
    //    return lhs.case == rhs.case
    //}
}
