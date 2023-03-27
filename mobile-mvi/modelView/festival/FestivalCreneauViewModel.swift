//
//  FestivalCreneauViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class FestivalCreneauViewModel : ObservableObject, Hashable, Equatable{//, UserModelObserver {
    
    @Published var idCreneau : Int
    @Published var heureDebut : String
    @Published var heureFin : String
    
    init(idCreneau: Int, heureDebut: String, heureFin: String) {
        self.idCreneau = idCreneau
        self.heureDebut = heureDebut
        self.heureFin = heureFin
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
                debugPrint("FestivalCreneauViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    static func == (lhs: FestivalCreneauViewModel, rhs: FestivalCreneauViewModel) -> Bool {
        return lhs.idCreneau == rhs.idCreneau
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idCreneau)
    }
}
