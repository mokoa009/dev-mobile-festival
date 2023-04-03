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
    @Published var idJour : Int
    @Published var benevolesNonAffecte: [UserViewModel]
    
    init(benevoles: [UserViewModel],idZone: Int,idCreneau : Int,idJour: Int, benevolesNonAffecte : [UserViewModel]) {
        self.benevoles = benevoles
        self.idZone = idZone
        self.idCreneau = idCreneau
        self.idJour = idJour
        self.benevolesNonAffecte = benevolesNonAffecte
    }
    
    func updateBenevoles(benevoleSelect: UserViewModel) {
        self.benevoles.append(benevoleSelect)
        self.benevolesNonAffecte.remove(at:self.benevolesNonAffecte.firstIndex(of:benevoleSelect)!)
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
            case .benevoleNonAdminAffected(let newBenevole):
                if(newBenevole != nil){
                    let benevole = UserViewModel(id: newBenevole!.idUtilisateur, nom:newBenevole!.nom, prenom: newBenevole!.prenom, email: newBenevole!.email)
                    if(!self.benevoles.contains(benevole)){
                        self.benevoles.append(benevole)
                    }else{
                        debugPrint("Vous êtes déjà affecté à ce créneau")
                    }
                }
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

