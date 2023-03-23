//
//  TrackModel.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

class Track {
    
    var trackName : String {
        didSet {
            for o in observers {
                o.change(name: self.trackName)
            }
        }
    }
    
    var artistName : String
    var collectionName : String
    var releaseDate : String
    
    var observers : [TrackModelObserver] = []
    
    init(trackName: String, artistName: String, collectionName: String, releaseDate: String) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.releaseDate = releaseDate
    }
    
    func register(_ o : TrackModelObserver) {
        self.observers.append(o)
    }
}
