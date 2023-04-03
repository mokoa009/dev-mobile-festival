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
    
    var body : some View {
        NavigationStack{
            ScrollView{
                VStack(alignment: .center) {
                        Text("Liste des bénévoles").font(.title)
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
                                                await userIntent.deleteUser(user: user,token: tokenManager.token?.string)
                                            }
                                        })
                                    }.buttonStyle(.bordered)
                                }
                            }.padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black)
                                )
                                .foregroundColor(.black)
                        }
                }
            }.task {
                await userIntent.getUsers()
            }
        }
    }
}
