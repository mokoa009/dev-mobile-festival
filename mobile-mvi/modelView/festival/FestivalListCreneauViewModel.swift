//
//  FestivalListCreneauViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

class FestivalListCreneauViewModel : ObservableObject {
    
    @Published var creneaux : [FestivalCreneauViewModel]
    @Published var idJour : Int
    
    init(creneaux: [FestivalCreneauViewModel], idJour : Int) {
        self.creneaux = creneaux
        self.idJour = idJour
    }

    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .loadingCreneaux:
                debugPrint("state loading CreneauVM")
            case .loadedCreneaux(let newCreneaux):
                //transformation CreneauJourDTO en CreneauViewModel
                debugPrint("dans state lisfestivalJFIDGDIGHD")
                debugPrint(newCreneaux)
                self.creneaux = newCreneaux.map{ creneau in creneau.convertToFestivalCreneauVM()}
                debugPrint("jai charge les donnees")
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

