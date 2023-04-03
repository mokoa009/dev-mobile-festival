//
//  ZoneCreneauBenevoleState.swift
//  mobile-mvi
//
//  Created by garcy on 27/03/2023.
//

import Foundation

enum ZoneCreneauBenevoleState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case loadingBenevoles
    case loadedBenevoles([ZoneCreneauBenevoleDTO])
    case deleteBenevole
    case deleted
    case updateBenevole
    case updated
    case affectationBenevole
    case benevoleAffected(UserViewModel)
    case loadingBenevolesNonAffect
    case loadedBenevolesNonAffect([UserDTO])
    case benevoleNonAdminAffected(User?)
}

