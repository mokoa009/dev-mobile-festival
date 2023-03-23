//
//  TrackViewModel.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

class TrackViewModel : ObservableObject, Hashable, Equatable, TrackModelObserver {
    
    var id = UUID()
    
    @Published var trackName : String
    var artistName : String
    var collectionName : String
    var releaseDate : String
    
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : TrackState = .ready {
        didSet {
            switch state {
            case .loadingUsers:
                print("state loading TrackVM")
            case .changingName(let newname):
                debugPrint("TrackViewModel: ", newname, " changed")
                // si le nom convient :
                self.trackName = newname
                self.state = .ready
                // sinon on fait passer le state en .error
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
    
    static func == (lhs: TrackViewModel, rhs: TrackViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    init(id: UUID = UUID(),trackName: String,artistName: String, collectionName: String, releaseDate: String) {
        self.id = id
        self.trackName = trackName
        self.state = .ready
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.collectionName=collectionName
        
    }
    
    func change(name: String) {
        self.trackName = name
    }
    
}
