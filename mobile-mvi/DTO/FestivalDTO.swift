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
    let annee: Date
    let nbJours: Int
    
    init(idFestival: Int, nom: String, annee: Date, nbJours: Int) {
        self.idFestival = idFestival
        self.nom = nom
        self.annee = annee
        self.nbJours = nbJours
    }
}


