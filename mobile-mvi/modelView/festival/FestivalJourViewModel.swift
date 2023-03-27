//
//  FestivalJourViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class FestivalJourViewModel : ObservableObject, Hashable, Equatable{//, UserModelObserver {
    
    @Published var idJour : Int
    @Published var nom : String
    @Published var ouverture : String
    @Published var fermeture : String
    
    init(idJour: Int, nom: String, ouverture: String, fermeture: String) {
        self.idJour = idJour
        self.nom = nom
        self.ouverture = ouverture
        self.fermeture = fermeture
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("UserViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    static func == (lhs: FestivalJourViewModel, rhs: FestivalJourViewModel) -> Bool {
        return lhs.idJour == rhs.idJour
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idJour)
    }
}
