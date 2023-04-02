//
//  FestivalListZoneViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation

class FestivalListZoneViewModel : ObservableObject {
    
    @Published var zones : [FestivalZoneViewModel]
    
    @Published var idJour : Int
    
    init(zones: [FestivalZoneViewModel], idJour : Int) {
        self.zones = zones
        self.idJour = idJour
    }

    @Published var state : FestivalState = .ready {
        didSet {
            switch state {
            case .loadingZones:
                debugPrint("state loading ZonesVM")
            case .loadedZones(let newZones):
                //transformation ZoneDTO en ZoneViewModel
                self.zones = []
                let tabZone = newZones.map{zone in
                    zone.convertToFestivalZoneVM()
                }
                tabZone.forEach{ zone in
                    self.zones.append(zone)
                }
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("FestivalZonesListViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}
