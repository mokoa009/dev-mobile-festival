//
//  UserDTO.swift
//  mobile-mvi
//
//  Created by garcy on 15/03/2023.
//

import Foundation

struct UserDTO: Codable, Hashable{
    let idUtilisateur: Int
    let nom: String
    let prenom: String
    let email: String
    let mdp: String
    let isAdmin: Int
}

struct ResponseUser: Decodable{
    var result : [UserDTO]
}


