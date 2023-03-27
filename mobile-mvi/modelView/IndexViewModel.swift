//
//  indexViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation

class IndexViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var nomFestival : String
    @Published var dateDebut : Int
    @Published var dateFin : Int
    @Published var nbrTotalBenevole : Int
    @Published var nbrTotalFestival : Int
    
    init() {
        self.nomFestival = ""
        self.dateDebut = 0
        self.dateFin = 0
        self.nbrTotalBenevole = 0
        self.nbrTotalFestival = 0
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : IndexState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("IndexViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}
