//
//  InscriptionView.swift
//  coursmobile
//
//  Created by garcy on 06/02/2023.
//

import Foundation
import SwiftUI

struct InscriptionView : View {
    
    @ObservedObject var user : InscriptionViewModel
    var inscriptionIntent : InscriptionIntent
    
    init(viewModel: InscriptionViewModel){
        self.user = viewModel
        self.inscriptionIntent = InscriptionIntent(model: viewModel)
    }
    
    var body: some View {
        VStack{
            Text("Inscription").font(.title)
            VStack{
                TextField(text: $user.nom){
                    Text("Nom :")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                TextField(text: $user.prenom){
                    Text("Prenom :")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                TextField(text: $user.email){
                    Text("Email : *")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                SecureField(text: $user.mdp){
                    Text("Mot de passe : *")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                SecureField(text: $user.mdpConfirm){
                    Text("Confirmation mot de passe : *")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            }.padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(.black)
                )
                .foregroundColor(.black)
            Button("Envoyer", action : {
                Task{
                    await inscriptionIntent.inscription()
                }
            }).buttonStyle(.bordered)
        }
    }
}

