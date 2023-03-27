//
//  FestivalDTO.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

struct FestivalDTO: Codable, Hashable{
    let idFestival: Int
    let nom: String
    let annee: Int
    let nbJours: Int
    let cloture: Int
    
    init(idFestival: Int, nom: String, annee: Int, nbJours: Int, cloture: Int) {
        self.idFestival = idFestival
        self.nom = nom
        self.annee = annee
        self.nbJours = nbJours
        self.cloture = cloture
    }
    
    func convertToFestival() -> Festival{
        let clotureBool : Bool
        
        clotureBool = self.cloture == 1
        
        return Festival(idFestival: self.idFestival, nom: self.nom, annee: self.annee, nbJours: self.nbJours, cloture: clotureBool)
    }
    
    func convertToUserVM() -> FestivalViewModel{
        let fest = self.convertToFestival()
        return FestivalViewModel(id: fest.idFestival, nom: fest.nom, annee: fest.annee, cloture: fest.cloture, nbJours: fest.nbJours)
    }
}

struct Festival {
    let idFestival: Int
    let nom: String
    let annee: Int
    let nbJours: Int
    let cloture: Bool
}
