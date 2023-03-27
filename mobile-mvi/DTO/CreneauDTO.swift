//
//  CreneauDTO.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

struct CreneauDTO: Codable, Hashable{
    let idCreneau: Int
    let heureDebut : String
    let heureFin : String
    
}

struct IdCreneauDTO: Codable,Hashable{
    let idCreneau: Int
}
