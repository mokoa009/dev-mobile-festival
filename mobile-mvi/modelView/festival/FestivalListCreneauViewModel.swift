//
//  FestivalListCreneauViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

class FestivalListCreneauViewModel : ObservableObject {
    
   
    @Published var zonesCreneaux : [FestivalCreneauViewModel]
    @Published var idJour : Int
    
    init(zonesCreneaux: [FestivalCreneauViewModel], idJour : Int) {
        self.zonesCreneaux = zonesCreneaux
        self.idJour = idJour
    }

    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .loadingCreneaux:
                debugPrint("state loading CreneauVM")
            case .loadedCreneaux(let newCreneauxZones):
                if(newCreneauxZones != []){
                    self.zonesCreneaux = []
                    let result = newCreneauxZones.reduce(into: [Zone: [Creneau]]()){ result,element in
                        guard let element = element else {return}
                        result[element.zone, default: []].append(element.creneau)
                    }
                    for(zone,creneaux) in result{
                        let festivalCreaneauVM = FestivalCreneauViewModel(id:UUID(),idZone: zone.id, nom: zone.nom, nbBenevoles: zone.nbBenevoles, creneaux: creneaux)
                        self.zonesCreneaux.append(festivalCreaneauVM)
                    }
                }
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
            case .deletingCreneau:
                debugPrint("deleting creneau")
            case .deletedCreneau(let creneauDeleted, let idZone):
                if let index = self.zonesCreneaux.firstIndex(where: {$0.idZone == idZone}),let creneauIndex = self.zonesCreneaux[index].creneaux.firstIndex(where: {$0 == creneauDeleted}){
                    self.zonesCreneaux[index].creneaux.remove(at: creneauIndex)
                }
            case .ready:
                debugPrint("FestivalListCreneauxViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}

