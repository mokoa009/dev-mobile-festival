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
    case loadedCreneaux([CreneauJourDTO])
    case loadingFestivals
    case loadedFestivals([FestivalDTO])
    case deleteFestival
    case deleted
}

