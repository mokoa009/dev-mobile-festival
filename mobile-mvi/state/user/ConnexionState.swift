//
//  ConnexionState.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import Foundation

enum ConnexionState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case connexion
    case authentification
    case authentified

    //var description: String{ ... }
    
    //static func == (lhs: Self, rhs: Self) -> Bool {
    //    return lhs.case == rhs.case
    //}
}
