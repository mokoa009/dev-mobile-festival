//
//  FestivalListJourViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class FestivalListJourViewModel : ObservableObject {
    
    @Published var jours : [FestivalJourViewModel]
    
    @Published var idFestival : Int
    
    init(jours: [FestivalJourViewModel], idFestival : Int) {
        self.jours = jours
        self.idFestival = idFestival
    }

    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .loadingJours:
                debugPrint("state loading JourVM")
            case .loadedJours(let newJours):
                //transformation JourDTO en JourViewModel
                self.jours = newJours.map{jour in
                   jour.convertToFestivalJourVM()
                }
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("FestivalJoursListViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}
