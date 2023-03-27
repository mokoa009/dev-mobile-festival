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
    
    init(benevoles: [UserViewModel],idZone: Int,idCreneau : Int) {
        self.benevoles = benevoles
        self.idZone = idZone
        self.idCreneau = idCreneau
    }
    
    func remove(atOffsets indexSet : IndexSet) {
        self.benevoles.remove(atOffsets: indexSet)
        self.objectWillChange.send()
    }
    
    func move(fromOffsets indexSet : IndexSet, toOffset index: Int) {
        self.benevoles.move(fromOffsets: indexSet, toOffset: index)
        self.objectWillChange.send()
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

