//
//  File.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import SwiftUI

struct ConnexionView: View {
    @ObservedObject var identifiant: ConnexionViewModel
    var connexionIntent : ConnexionIntent
    
    init(viewModel: ConnexionViewModel) {
        self.identifiant = viewModel
        self.connexionIntent = ConnexionIntent(model:viewModel)
    }
    
    var body: some View {
        VStack{
            Text("Connexion")
            Text("test")
            TextField(text: $identifiant.email){
                Text("Email : *")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            SecureField(text: $identifiant.mdp){
                Text("Mot de passe : *")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            Button("Envoyer", action : {
                debugPrint(identifiant.email)
                debugPrint(identifiant.mdp)
                Task{
                    await connexionIntent.connexion()
                }
            })
        }
    }
}

/*
struct TrackItemView_Previews: PreviewProvider {
    static var previews: some View {
        TrackItemView(track: TrackViewModel(trackName: "coucou", artistName: "coucou", collectionName: "coucou", releaseDate: "coucou"))
    }
}*/

