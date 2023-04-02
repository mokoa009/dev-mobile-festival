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
                debugPrint("JE SUIS DANS LA CRENEAU ZONE")
                debugPrint(newCreneauxZones)
                
                if(newCreneauxZones != []){
                    /*let result = newCreneauxZones.reduce(into: [Int: [Creneau]]()){ result,element in
                        guard let element = element else {return}
                        result[element.zone.id, default: []].append(element.creneau)
                    }*/
                    
                    let result = newCreneauxZones.reduce(into: [Zone: [Creneau]]()){ result,element in
                        guard let element = element else {return}
                        result[element.zone, default: []].append(element.creneau)
                    }
                    debugPrint("TRANSFORMATION")
                    debugPrint(result)
                   /* [@Published var idZone : Int
                    @Published var nom : String
                    @Published var nbBenevoles : Int
                    @Published var creneaux : [Creneau]]*/
                    for(zone,creneaux) in result{
                        let festivalCreaneauVM = FestivalCreneauViewModel(idZone: zone.id, nom: zone.nom, nbBenevoles: zone.nbBenevoles, creneaux: creneaux)
                        self.zonesCreneaux.append(festivalCreaneauVM)
                    }
                    /*
                    newCreneauxZones.forEach(){ zoneCreneau in
                        self.zonesCreneaux.append(FestivalCreneauViewModel(idZone: zoneCreneau?.zone.id, nom: zoneCreneau?.zone.nom, nbBenevoles: zoneCreneau?.zone.nbBenevoles, creneaux: zoneCreneau?.creneau))
                    }*/
                }
                debugPrint("AFTER AFFEC")
                debugPrint(zonesCreneaux)
            
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("FestivalListCreneauxViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}

