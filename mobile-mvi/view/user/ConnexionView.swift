//
//  File.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//
import Foundation
import SwiftUI
import JWTDecode

struct ConnexionView: View {
    
    @EnvironmentObject var tokenManager: Token
    @ObservedObject var identifiant: ConnexionViewModel
    var connexionIntent : ConnexionIntent
    
    init(viewModel: ConnexionViewModel) {
        self.identifiant = viewModel
        self.connexionIntent = ConnexionIntent(model:viewModel)
    }
    
    var body: some View {
        if(tokenManager.token == nil){
            VStack{
                Text("Connexion")
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
                        let token : JWT? = await connexionIntent.connexion()
                        if(token != nil){
                            tokenManager.token = token
                        }
                    }
                })
            }.onReceive(tokenManager.objectWillChange){
                debugPrint("je suis co !!!")
            }
        }else{
            Text("Vous êtes déjà connecté ! ")
        }
        
    }
}
