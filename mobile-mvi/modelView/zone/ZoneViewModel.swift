//
//  ZoneViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class ZoneViewModel : ObservableObject, Hashable, Equatable{//, UserModelObserver {
    
    @Published var id : Int
    @Published var nom : String
    @Published var nbBenevoles : Int
    
    init(id: Int, nom: String, nbBenevoles: Int) {
        self.id = id
        self.nom = nom
        self.nbBenevoles = nbBenevoles
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : ZoneState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("ZoneViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    static func == (lhs: ZoneViewModel, rhs: ZoneViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
