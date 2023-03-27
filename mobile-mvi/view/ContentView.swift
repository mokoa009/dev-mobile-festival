//
//  ContentView.swift
//  mobile-mvi
//
//  Created by garcy on 14/02/2023.
//
import Foundation
import SwiftUI


struct ContentView : View {
    
    var body: some View {
        TabView{
            IndexView(viewModel: IndexViewModel())
                .tabItem{
                    Label("Accueil", systemImage: "house.fill")
                }
            ZoneListView(viewModel: ZoneListViewModel(zones: [],idFestival:1))
                .tabItem{
                    Label("Festivals", systemImage: "gamecontroller.fill")
                }
            UserListView(viewModel: UserListViewModel(users: []))
                .tabItem{
                    Label("Utilisateurs", systemImage: "person.3.fill")
                }
            if (Token.isConnected()) {
                ProfilView(viewModel: ProfilViewModel(id: Token.getIdUtilisateur()))
                    .tabItem{
                        Label("Profil", systemImage: "person.circle")
                    }
            }else{
                ConnexionView(viewModel: ConnexionViewModel())
                    .tabItem{
                        Label("Connexion", systemImage: "person.circle.fill")
                    }
                InscriptionView(viewModel: InscriptionViewModel())
                    .tabItem{
                        Label("Inscription", systemImage: "person.badge.plus")
                    }
            }
        }
    }
}
struct ContentViewList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
