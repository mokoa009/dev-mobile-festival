//
//  UserItemView.swift
//
//  Created by garcy on 13/02/2023.
//
import Foundation
import SwiftUI

struct UserItemView: View {
    @ObservedObject var user: UserViewModel
    
    init(user: UserViewModel) {
        self.user = user
    }
    
    var body: some View {
        Text(user.nom)
        Text(user.prenom)
        Text(user.email)
    }
}

/*
struct TrackItemView_Previews: PreviewProvider {
    static var previews: some View {
        TrackItemView(track: TrackViewModel(trackName: "coucou", artistName: "coucou", collectionName: "coucou", releaseDate: "coucou"))
    }
}*/
