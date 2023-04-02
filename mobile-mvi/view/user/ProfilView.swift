//
//  ProfilView.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation
import SwiftUI

struct ProfilView : View {
    
    @EnvironmentObject var tokenManager: Token
    @ObservedObject var user : ProfilViewModel
    var profilIntent : ProfilIntent
    
    init(viewModel: ProfilViewModel){
        self.user = viewModel
        self.profilIntent = ProfilIntent(model: viewModel)
    }
    
    var body: some View {
        VStack{
            Text("Profil")
            Button("Déconnexion", action :tokenManager.deconnexion)
            TextField(text: $user.nom){
                Text("Nom :")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField(text: $user.prenom){
                Text("Prenom :")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            TextField(text: $user.email){
                Text("Email : ")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            Toggle("Administrateur",isOn: $user.isAdmin)
            Button("Envoyer", action : {
                Task{
                    await profilIntent.update(token: tokenManager.token?.string)
                }
            })
        }.task {
            await profilIntent.getUserById(id: user.id, token: tokenManager.token?.string)
        }
    }
}

