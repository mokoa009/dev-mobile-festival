//
//  ListBenevole.swift
//  mobile-mvi
//
//  Created by garcy on 29/03/2023.
//

import Foundation
import SwiftUI

struct UserNonAffecteListView : View {
    
    @EnvironmentObject var tokenManager : Token
    @ObservedObject var users : UserNonAffecteListViewModel
    var intent : UserNonAffecteIntent
    @Environment(\.dismiss) var dismiss
   

    init(viewModel : UserNonAffecteListViewModel){
        self.users = viewModel
        self.intent = UserNonAffecteIntent(model: viewModel)
    }
    
    var body : some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(users.users, id: \.self) { user in
                        VStack{
                            Text("Utilisateur n° \(user.id)")
                            Text("Nom : " + user.nom)
                            Text("Prenom : "+user.prenom)
                            Text("Email : "+user.email)
                            
                            Button("+", action: {
                                Task{
                                    await  intent.affecterZoneCreneauBenevole(utilisateurSelect: user,token: tokenManager.token?["token"].string)
                                }
                                debugPrint("tiens l'id select")
                                dismiss()
                            })
                        }
                    }
                }
            }
        }.task {
            await intent.getUsers()
        }
    }
}
