//
//  FestivalCreneauViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class FestivalCreneauViewModel : ObservableObject, Hashable, Equatable{//, UserModelObserver {
    
    let id : UUID
    @Published var idZone : Int
    @Published var nom : String
    @Published var nbBenevoles : Int
    @Published var creneaux : [Creneau]
    
    init(id: UUID,idZone: Int,nom:String,nbBenevoles:Int,creneaux: [Creneau]) {
        self.id = id
        self.idZone = idZone
        self.nom = nom
        self.nbBenevoles = nbBenevoles
        self.creneaux = creneaux
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
        return lhs.idZone == rhs.idZone
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idZone)
    }
}
