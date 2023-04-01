//
//  TrackViewModel.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

class FestivalViewModel : ObservableObject, Hashable, Equatable{//, FestivalModelObserver {
    
    @Published var id : Int
    @Published var nom : String
    @Published var annee : Int
    @Published var nbJours : Int
    @Published var cloture : Bool
    
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("FestivalViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    static func == (lhs: FestivalViewModel, rhs: FestivalViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    init(id: Int, nom: String, annee: Int, cloture: Bool, nbJours: Int) {
        self.id = id
        self.nom = nom
        self.annee = annee
        self.cloture = cloture
        self.nbJours = nbJours
    }
}
