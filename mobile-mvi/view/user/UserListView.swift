//
//  UserListView.swift
//  mobile-mvi
//
//  Created by garcy on 20/03/2023.
//
import Foundation
import SwiftUI

struct UserListView : View {
    
    @ObservedObject var users : UserListViewModel
    var userIntent : UserIntent
    
    init(viewModel : UserListViewModel){
        self.users = viewModel
        self.userIntent = UserIntent(model: viewModel)
    }
    
    func supprimerUser(id : Int) async{
        debugPrint("utilisateur supprimé")
        await userIntent.deleteUser(id: id)
    }
    
    
    
    func modifierUser(){
        debugPrint("modifier utilisateur")
    }
    var body : some View {
        
        ZStack{
            Rectangle()
                        .fill(Gradient(colors: [.indigo, .purple]))
                        .ignoresSafeArea()
            Text("BOBOBLO").foregroundColor(Color.white)
        }
        
        NavigationStack{
            VStack {
                List{
                    ForEach(users.users, id: \.self) { user in
                        NavigationLink(destination: UserItemView(user: user)){
                            Text("Utilisateur n° \(user.id)")
                            Text("Nom : " + user.nom)
                            Text("Prenom : "+user.prenom)
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
            }.environment(\.colorScheme, .dark)
        //}.onAppear(){
          //  debugPrint("chargement data ?")
          //  Task{
           //     await userIntent.getUsers(of: users)
         //   }
        }.task {
            await userIntent.getUsers()
        }
    }
}
