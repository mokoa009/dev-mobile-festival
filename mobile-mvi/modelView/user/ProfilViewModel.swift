//
//  ProfilViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation

class ProfilViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var id : Int
    @Published var nom : String
    @Published var prenom : String
    @Published var email : String
    @Published var isAdmin : Bool
    
    init(id : Int) {
        self.id = id
        self.prenom = ""
        self.nom = ""
        self.email = ""
        self.isAdmin = false
    }

    // -----------------------------------------------------------
    // State Intent management
    @Published var state : UserState = .ready {
        didSet {
            switch state {
                case .error:
                    debugPrint("error")
                    self.state = .ready
                case .ready:
                    debugPrint("ProfilViewModel: ready state")
                    debugPrint("--------------------------------------")
                case .updatingUser:
                    debugPrint("demande modification user")
                case .updated:
                    debugPrint("modification réussie")
                case .loadUser:
                    debugPrint("chargement profil")
                case .loadedUser(let profilUser):
                    debugPrint("user chargé")
                    self.nom = profilUser.nom
                    self.prenom = profilUser.prenom
                    self.email = profilUser.email
                    self.isAdmin = profilUser.isAdmin
                    self.state = .ready
                default:
                    break
                }
        }
    }
}
