//
//  ZoneDTO.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

struct ZoneDTO: Codable,Hashable{
    let zone : Zone
    let festival : FestivalZone
    
    func convertToZoneVM() -> ZoneViewModel{
        return ZoneViewModel(id: zone.id, nom: zone.nom, nbBenevoles: zone.nbBenevoles)
    }
}

struct Zone: Codable, Hashable{
    let id: Int
    let nom: String
    let nbBenevoles: Int
}

struct FestivalZone: Codable, Hashable{
    let id: Int
    let nom: String
    let cloture: Int
}
