//
//  CreneauState.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

enum CreneauState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case demandeCreation
    case creneauCreated
    case affectationCreneau
    case creneauAffected
    case getIdCreneau
    case idCreneauRecu(Int)
}
