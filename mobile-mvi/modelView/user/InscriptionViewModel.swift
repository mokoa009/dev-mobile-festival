//
//  InscriptionViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import Foundation

class InscriptionViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var nom : String
    @Published var prenom : String
    @Published var email : String
    @Published var mdp : String
    @Published var mdpConfirm : String
    @Published var isAdmin : Int
    
    
    init() {
        self.prenom = ""
        self.nom = ""
        self.email = ""
        self.mdp = ""
        self.mdpConfirm = ""
        self.isAdmin = 0
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : InscriptionState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("InscriptionViewModel: ready state")
                debugPrint("--------------------------------------")
            case .demandeInscription:
                debugPrint("demande inscription")
            case .inscription:
                debugPrint("inscription réussie")
            default:
                break
            }
        }
    }
}
