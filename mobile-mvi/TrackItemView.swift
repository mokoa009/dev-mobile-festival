//
//  TrackItemView.swift
//  coursmobile
//
//  Created by Oce on 13/02/2023.
//

import SwiftUI

struct TrackItemView: View {
    @ObservedObject var track: TrackViewModel
    var body: some View {
        Text(track.trackName)
    }
}

struct TrackItemView_Previews: PreviewProvider {
    static var previews: some View {
        TrackItemView(track: TrackViewModel(trackName: "coucou", artistName: "coucou", collectionName: "coucou", releaseDate: "coucou"))
    }
}
