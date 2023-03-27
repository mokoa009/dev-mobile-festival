//
//  FestivalListViewModel.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import Foundation

class FestivalListViewModel : ObservableObject, FestivalModelObserver {
    
    @Published var festivals : [FestivalViewModel]
    
    init(festivals: [FestivalViewModel]) {
        self.festivals = festivals
    }
    
    func change(name: String) {
        self.objectWillChange.send()
    }
    
    func remove(atOffsets indexSet : IndexSet) {
        self.festivals.remove(atOffsets: indexSet)
        self.objectWillChange.send()
    }
    
    func move(fromOffsets indexSet : IndexSet, toOffset index: Int) {
        self.festivals.move(fromOffsets: indexSet, toOffset: index)
        self.objectWillChange.send()
    }
    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .loadingFestivals:
                debugPrint("state loading FestivalVM")
            case .loadedFestivals(let newFestivals):
                //transformation FestivalDTO en FestivalViewModel
                self.festivals = newFestivals.map{ festival in  festival.convertToUserVM()}
                debugPrint("jai charge les donnees")
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("TrackViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}
