//
//  ContentView.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import SwiftUI

struct ContentView : View {
    
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink(destination: ConnexionView(viewModel: ConnexionViewModel())){
                    Text("Connexion")
                }
                NavigationLink(destination: InscriptionView(viewModel: InscriptionViewModel())){
                    Text("Inscription")
                }
                UserListView(viewModel: UserListViewModel(users: []))
            }
     
        UserListView(viewModel: UserListViewModel(users: []))
        FestivalListView(viewModel: FestivalListViewModel(festivals: []))
        
    }
}
struct ContentViewList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
