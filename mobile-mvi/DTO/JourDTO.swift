//
//  JourDTO.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

//------structures pour avoir juste les jours----
struct JourDTO: Codable, Hashable{
    let jour: Jour
    let festival : FestivalAffecJour
    
    
    func convertToFestivalJourVM() -> FestivalJourViewModel{
        return FestivalJourViewModel(idJour: jour.id, nom: jour.nom, ouverture: jour.ouverture, fermeture: jour.fermeture)
    }
}

struct Jour: Codable, Hashable{
    let id: Int
    let nom: String
    let ouverture: String
    let fermeture: String
}
struct FestivalAffecJour: Codable, Hashable{
    let id: Int
    let nom: String
    let cloture: Int
}



