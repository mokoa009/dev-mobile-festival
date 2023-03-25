//
//  ContentView.swift
//  mobile-mvi
//
//  Created by garcy on 14/02/2023.
//

import SwiftUI


struct ContentView : View {
    
    var body: some View {
        NavigationStack{
            VStack {
                if (Token.isConnected()) {
                    NavigationLink(destination: ProfilView(viewModel: ProfilViewModel(id: Token.getIdUtilisateur()))){
                        Text("Profil")
                   }
                    Button("Déconnexion", action :Token.deconnexion)
                }else{
                    NavigationLink(destination: ConnexionView(viewModel: ConnexionViewModel())){
                        Text("Connexion")
                    }
                    NavigationLink(destination: InscriptionView(viewModel: InscriptionViewModel())){
                        Text("Inscription")
                    }
                }
                UserListView(viewModel: UserListViewModel(users: []))
            }
        }
    }
}
struct ContentViewList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
