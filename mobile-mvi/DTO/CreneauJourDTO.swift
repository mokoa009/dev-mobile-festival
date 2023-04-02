//
//  CreneauZoneDTO.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

//------structures pour avoir juste les jours----
struct CreneauZoneDTO: Codable, Hashable{
    let zone: Zone
    let creneau : Creneau
    
    
    /*func convertToFestivalCreneauVM() -> FestivalCreneauViewModel{
        return FestivalCreneauViewModel(idCreneau: creneau.id, heureDebut: creneau.heureDebut, heureFin: creneau.heureFin)
    }*/
}

struct Creneau: Codable, Hashable{
    let id: Int
    let heureDebut: String
    let heureFin: String
}
