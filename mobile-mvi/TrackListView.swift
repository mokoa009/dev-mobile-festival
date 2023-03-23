//
//  TrackListView.swift
//  coursmobile
//
//  Created by Oce on 06/02/2023.
//

import Foundation
import SwiftUI

struct TrackListView : View {
    
    @ObservedObject var tracks : TrackListViewModel
    var trackIntent = TrackIntent()
    
    init(tracks : TrackListViewModel) {
        self.tracks = tracks
    }
    
    var body : some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(tracks.tracks, id: \.self) { track in
                        NavigationLink(value: track){
                            TrackItemView(track: track)
                            //Text(track.trackName)
                        }.navigationTitle("Liste des titres")
                    }.onDelete { indexSet in tracks.remove(atOffsets: indexSet)
                    }
                    .onMove{ indexSet, index in tracks.move(fromOffsets: indexSet, toOffset: index)
                    }
        
                }.navigationDestination(for: TrackViewModel.self) { track in
                    TrackUIView(track: track, intent: trackIntent)
                }
                TrackItemView(track: tracks.tracks[0])
                Button("Modifier le nom") {
                    tracks.change(name: "nom", at: 0)
                    // 12 bis question 7
                    // ça modifie mais la vue n’est pas à jour jusqu’a ce qu’on le déplace
                    // du coup avec TrackListViewModel c’est bon
                }
                
                EditButton()
            }
        }
    }
}
