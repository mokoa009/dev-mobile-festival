//
//  ZoneCreneauBenevoleDTO.swift
//  mobile-mvi
//
//  Created by garcy on 27/03/2023.
//


import Foundation

struct ZoneCreneauBenevoleDTO: Codable,Hashable{
    let idUtilisateur : Int
    let nomUtilisateur : String
    let prenom : String
    let email : String
    
    func convertToUserVM() -> UserViewModel{
        return UserViewModel(id: self.idUtilisateur, nom: self.nomUtilisateur, prenom: self.prenom, email: self.email)
    }
}

