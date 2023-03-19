//
//  ContentView.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import SwiftUI

struct ContentView : View {
   
    
    @StateObject var tracks = TrackListViewModel(tracks: [
        TrackViewModel(trackName: "That's Life", artistName: "James Brown", collectionName: "Gettin' Down to It", releaseDate: "1969-05-01T12:00:00Z"),
        TrackViewModel(trackName: "Shoot the Moon", artistName: "Norah Jones", collectionName: "Come Away With Me (Deluxe Edition)", releaseDate: "2002-02-26T08:00:00Z"),
        TrackViewModel(trackName: "Kozmic Blues", artistName: "Janis Joplin", collectionName: "I Got Dem Ol' Kozmic Blues Again Mama!", releaseDate: "1969-09-11T07:00:00Z"),
        TrackViewModel(trackName: "You Found Another Lover (I Lost Another Friend)", artistName: "Ben Harper & Charlie Musselwhite", collectionName: "Get Up! (Deluxe Version)", releaseDate: "2013-01-29T12:00:00Z")
    ])
    
    var body: some View {
        TrackListView(tracks: tracks)
    }
    
}

struct ContentViewList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
