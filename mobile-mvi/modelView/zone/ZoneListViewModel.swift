//
//  ZoneListViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//


import Foundation

class ZoneListViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var zones : [ZoneViewModel]
    @Published var idFestival : Int
    
    init(zones: [ZoneViewModel],idFestival: Int) {
        self.zones = zones
        self.idFestival = idFestival
    }
    
    func remove(atOffsets indexSet : IndexSet) {
        self.zones.remove(atOffsets: indexSet)
        self.objectWillChange.send()
    }
    
    func move(fromOffsets indexSet : IndexSet, toOffset index: Int) {
        self.zones.move(fromOffsets: indexSet, toOffset: index)
        self.objectWillChange.send()
    }
    @Published var state : ZoneState = .ready {
        didSet {
            switch state {
            case .loadingZones:
                debugPrint("state loading ZoneVM")
            case .loadedZones(let newZones):
                //transformation ZoneDTO en ZoneViewModel
                self.zones = newZones.map{ zone in zone.convertToZoneVM()}
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

