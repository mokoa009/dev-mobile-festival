//
//  TrackListViewModel.swift
//  coursmobile
//
//  Created by Oce on 06/02/2023.
//

import Foundation

class TrackListViewModel : ObservableObject, TrackModelObserver {
    
    @Published var tracks : [TrackViewModel] = []
    
    init(tracks: [TrackViewModel]) {
        self.tracks = tracks
    }
    
    func change(name: String, at index: Int) {
        self.tracks[index].trackName = name
        self.objectWillChange.send()
        // c’est équivalent à intentToChange
    }
    
    func change(name: String) {
        self.objectWillChange.send()
    }
    
    func remove(atOffsets indexSet : IndexSet) {
        self.tracks.remove(atOffsets: indexSet)
        self.objectWillChange.send()
    }
    
    func move(fromOffsets indexSet : IndexSet, toOffset index: Int) {
        self.tracks.move(fromOffsets: indexSet, toOffset: index)
        self.objectWillChange.send()
    }
}
