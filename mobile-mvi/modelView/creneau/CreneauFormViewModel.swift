//
//  CreneauFormViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation


class CreneauFormViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var idCreneau : Int
    @Published var heureDebut : String
    @Published var heureFin : String
    
    init() {
        self.idCreneau = -1
        self.heureDebut = ""
        self.heureFin = ""
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : CreneauState = .ready {
        didSet {
            switch state {
                case .error:
                    debugPrint("error")
                    self.state = .ready
                case .ready:
                    debugPrint("ICreneauFormViewModel: ready state")
                    debugPrint("--------------------------------------")
                case .demandeCreation:
                    debugPrint("demande création créneau")
                case .creneauCreated:
                    debugPrint("créneau crée")
                case .creneauAffected:
                    debugPrint("créneau affecté")
                    self.state = .ready
                case .getIdCreneau:
                    debugPrint("demande id creneau")
                case .idCreneauRecu(let id):
                    self.idCreneau = id
                default:
                    break
                }
        }
    }
}
