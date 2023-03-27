//
//  ZoneState.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

enum ZoneState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case loadingZones
    case loadedZones([ZoneDTO])
    case deleteZone
    case deleted
    case updateZone
    case updated
    //var description: String{ ... }
    
    //static func == (lhs: Self, rhs: Self) -> Bool {
    //    return lhs.case == rhs.case
    //}
}

