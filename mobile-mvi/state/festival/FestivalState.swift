//
//  FestivalState.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

enum FestivalState {//}: Equatable {//: CustomStringConvertible {//, Equatable {
    case ready
    case error
    case loadingJours
    case loadedJours([JourDTO])
    case loadingCreneaux
    case loadedCreneaux([CreneauZoneDTO?])
    case loadedFestivals([FestivalDTO])
    case loadingFestivals
    case deletingFestival(FestivalDTO)
    case deleted
    case cloturingFestival(FestivalDTO)
    case clotured
    case addingFestival(FestivalDTO)
    case added
    case loadingZones
    case loadedZones([ZoneAffectationDTO])
}

