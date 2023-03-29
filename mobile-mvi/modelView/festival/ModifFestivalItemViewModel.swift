//
//  ModifFestivalItemViewModel.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
class ModifFestivalItemViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var id : Int
    @Published var nom : String
    @Published var annee : Int
    @Published var nbJours : Int
    
    init(id : Int) {
        self.id = id
        self.nom = ""
        self.annee = 0
        self.nbJours = 0
    }
    
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : ModifFestivalState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("ProfilViewModel: ready state")
                debugPrint("--------------------------------------")
            case .updateFestival:
                debugPrint("demande modification festival")
            case .updated:
                debugPrint("modification réussie")
            case .loadFestival:
                debugPrint("chargement d'un festival")
            case .loadedFestival(let festival):
                debugPrint("user chargé")
                self.nom = festival.nom
                self.annee = festival.annee
                self.nbJours = festival.nbJours
                self.state = .ready
            }
        }
    }
    
}
