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
    @Published var annee : String
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
    
    init(Festival : FestivalDTO) {
        self.id = Festival.idFestival
        self.nom = Festival.nom
        self.annee = Festival.annee
        self.nbJours = Festival.nbJours
        self.cloture = Festival.cloture
    }
}
