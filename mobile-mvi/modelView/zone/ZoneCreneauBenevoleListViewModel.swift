//
//  ZoneCreneauBenevoleListViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 27/03/2023.
//

import Foundation

class ZoneCreneauBenevoleListViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var benevoles : [UserViewModel]
    @Published var idZone : Int
    @Published var idCreneau: Int
    @Published var benevolesNonAffecte: [UserViewModel]
    
    init(benevoles: [UserViewModel],idZone: Int,idCreneau : Int, benevolesNonAffecte : [UserViewModel]) {
        self.benevoles = benevoles
        self.idZone = idZone
        self.idCreneau = idCreneau
        self.benevolesNonAffecte = benevolesNonAffecte
    }
    
    func updateBenevoles(benevoleSelect: UserViewModel) {
        self.benevoles.append(benevoleSelect)
        self.benevolesNonAffecte.remove(at:self.benevolesNonAffecte.firstIndex(of:benevoleSelect)!)
        debugPrint("le vmodue")
       
        //self.objectWillChange.send()//notifie la vue qu'elle a changé
    }
    
    @Published var state : ZoneCreneauBenevoleState = .ready {
        didSet {
            switch state {
            case .loadingBenevoles:
                debugPrint("state loading ZoneCreneauBenevoleVM")
            case .loadedBenevoles(let newBenevoles):
                //transformation ZoneCreneauBenevoleDTO en UserViewModel
                self.benevoles = newBenevoles.map{ benevole in benevole.convertToUserVM()}
                debugPrint("jai charge les donnees")
                self.state = .ready
            case .loadingBenevolesNonAffect:
                debugPrint("chargement benevole non affecte")
            case .loadedBenevolesNonAffect(let newBenevoles):
                self.benevolesNonAffecte = newBenevoles.map{ benevole in benevole.convertToUserVM()
                }
            case .affectationBenevole:
                debugPrint("demande affectation benevole creneau")
            case .benevoleAffected(let newBenevole):
                updateBenevoles(benevoleSelect: newBenevole)
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("ZoneListViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}

