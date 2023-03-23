//
//  TrackUIView.swift
//  coursmobile
//
//  Created by Oce on 06/02/2023.
//

import Foundation
import SwiftUI

struct TrackUIView : View {
    
    @State var track : TrackViewModel
    var intent : TrackIntent
    @State var name : String
    
    init(track : TrackViewModel, intent : TrackIntent) {
        self.track = track
        self.intent = intent
        self.name = track.trackName
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Musique : ", text: $name).font(.title)
                .onSubmit {
                    intent.change(name: name, of: track)
                }
            Text("De \(track.artistName)")
            Text(track.collectionName).font(.headline)
            Text(track.releaseDate)
            Spacer()
        }
    }
}
