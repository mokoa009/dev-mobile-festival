//
//  UserListView.swift
//  mobile-mvi
//
//  Created by garcy on 20/03/2023.
//
import Foundation
import SwiftUI

struct UserListView : View {
    
    @EnvironmentObject var tokenManager: Token
    @ObservedObject var users : UserListViewModel
    var userIntent : UserIntent
    
    init(viewModel : UserListViewModel){
        self.users = viewModel
        self.userIntent = UserIntent(model: viewModel)
    }
    
    func supprimerUser(id : Int) async{
        await userIntent.deleteUser(id: id,token: tokenManager.token?["token"].string)
    }
    
    
    
    func modifierUser(){
        debugPrint("modifier utilisateur")
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
                            if(tokenManager.isAdmin()){
                                HStack{
                                    Button("Supprimer", action: {
                                        Task{
                                            await supprimerUser(id: user.id)
                                        }
                                    })
                                    Button("Modifer", action: modifierUser)
                                }.buttonStyle(.bordered)
                            }
                        }
                    }
                }
            }
        }.task {
            await userIntent.getUsers()
        }
    }
}
