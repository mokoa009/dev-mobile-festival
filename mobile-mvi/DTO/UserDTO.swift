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
    
    
    init(idUtilisateur: Int, nom: String, prenom: String, email: String, mdp: String, isAdmin: Int) {
        self.idUtilisateur = idUtilisateur
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.mdp = mdp
        self.isAdmin = isAdmin
    }
    
    init(idUtilisateur: Int, nom: String, prenom: String, email: String, isAdmin: Int) {
        self.idUtilisateur = idUtilisateur
        self.nom = nom
        self.prenom = prenom
        self.email = email
        self.mdp = ""
        self.isAdmin = isAdmin
    }
    
    func convertToUser() -> User{
        let isAdminBool : Bool
        
        isAdminBool = self.isAdmin == 1
        
        return User(idUtilisateur: self.idUtilisateur, nom: self.nom, prenom: self.prenom, email: self.email, isAdmin: isAdminBool)
    }
    
    func convertToUserVM() -> UserViewModel{
        return UserViewModel(id: self.idUtilisateur, nom: self.nom, prenom: self.prenom, email: self.email)
    }
    
    
}

struct User{
    let idUtilisateur: Int
    let nom: String
    let prenom: String
    let email: String
    let isAdmin: Bool
}


