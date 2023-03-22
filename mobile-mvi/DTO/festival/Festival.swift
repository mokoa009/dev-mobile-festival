//
//  Festival.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import Foundation

struct FestivalDTO: Codable, Hashable{
    let idFestival: Int
    let nom: String
    let annee: String
    let nbJours: Int
    let cloture: Bool
}

struct ResponseFestival: Decodable{
    var result : [FestivalDTO]
}
