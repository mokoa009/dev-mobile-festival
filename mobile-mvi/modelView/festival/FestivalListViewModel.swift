//
//  FestivalListViewModel.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import Foundation

class FestivalListViewModel : ObservableObject {
    
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
    
    func remove(festival : FestivalDTO) {
        let festivalVM = festival.convertToUserVM()
        let index = self.festivals.firstIndex(of: festivalVM)
        self.festivals.remove(at: index!)
        self.objectWillChange.send()
    }
    
    func cloture(festival : FestivalDTO) {
        let festivalVM = festival.convertToUserVM()
        let index = self.festivals.firstIndex(of: festivalVM)
        self.festivals[index!].cloture = true
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
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
                
            case .deletingFestival(let festival):
                self.remove(festival: festival)
                debugPrint("supression du festival")
            case .deleted:
                debugPrint("festival supprimé")
            case .cloturingFestival(let festival):
                self.cloture(festival: festival)
                debugPrint("clôturation du festival")
            case .clotured:
                debugPrint("festival clôturé")
            case .ready:
                debugPrint("FestivalListViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}
