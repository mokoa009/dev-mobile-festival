//
//  AjoutFestivalViewModel.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

class AjoutFestivalViewModel : ObservableObject{
    
    @Published var nom : String
    @Published var annee : Int
    @Published var nbJours : Int
    var list : FestivalListViewModel
    
    init(list : FestivalListViewModel) {
        self.nom = ""
        self.annee = 0
        self.nbJours = 0
        self.list = list
    }
    
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : AjoutFestivalState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("ProfilViewModel: ready state")
                debugPrint("--------------------------------------")
            case .addingFestival(let festival):
                self.list.festivals.append(festival.convertToUserVM())
                debugPrint("demande d'ajout festival")
            case .added:
                debugPrint("ajout réussi")
            }
        }
    }
}
