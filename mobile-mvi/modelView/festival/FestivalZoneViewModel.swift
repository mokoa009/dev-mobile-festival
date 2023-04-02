//
//  FestivalZoneViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class FestivalZoneViewModel : ObservableObject, Hashable, Equatable{//, UserModelObserver {
    
    @Published var idZone : Int
    @Published var nom : String
    @Published var nbBenevoles : Int
    
    init(idZone: Int, nom: String, nbBenevoles: Int) {
        self.idZone = idZone
        self.nom = nom
        self.nbBenevoles = nbBenevoles
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
                debugPrint("FestivalZoneViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    static func == (lhs: FestivalZoneViewModel, rhs: FestivalZoneViewModel) -> Bool {
        return lhs.idZone == rhs.idZone
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.idZone)
    }
}
