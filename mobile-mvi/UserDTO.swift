//
//  UserDTO.swift
//  mobile-mvi
//
//  Created by garcy on 15/03/2023.
//

import Foundation

struct UserDTO: Codable, Hashable{
    let id: Int?
    let nom: String
    let prenom: String
    let email: String
}

struct ResponseUser: Decodable{
    var data : UserDTO
}


