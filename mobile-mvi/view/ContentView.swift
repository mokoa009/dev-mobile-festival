//
//  ContentView.swift
//  mobile-mvi
//
//  Created by garcy on 14/02/2023.
//
import Foundation
import SwiftUI


struct ContentView : View {
    @EnvironmentObject var tokenManager : Token
    
    var body: some View {
            TabView{
                FestivalListView(viewModel: FestivalListViewModel(festivals: []))
                    .tabItem{
                        Label("Festivals", systemImage: "gamecontroller.fill").foregroundColor(.green)
                    }
                UserListView(viewModel: UserListViewModel(users: []))
                    .tabItem{
                        Label("Utilisateurs", systemImage: "person.3.fill").foregroundColor(.green)
                    }
                if (tokenManager.token != nil) {
                    ProfilView(viewModel: ProfilViewModel(id: tokenManager.getIdUtilisateur()))
                        .tabItem{
                            Label("Profil", systemImage: "person.circle").foregroundColor(.green)
                        }
                }else{
                    ConnexionView(viewModel: ConnexionViewModel())
                        .tabItem{
                            Label("Connexion", systemImage: "person.circle.fill").foregroundColor(.green)
                        }
                    InscriptionView(viewModel: InscriptionViewModel())
                        .tabItem{
                            Label("Inscription", systemImage: "person.badge.plus").foregroundColor(.green)
                        }
                }//.buttonStyle(.bordered).background(.black)
            }
    }
        
}
struct ContentViewList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
