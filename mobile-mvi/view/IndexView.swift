//
//  index.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation
import SwiftUI

struct IndexView : View {
    
    @ObservedObject var festival : IndexViewModel
    var indexIntent : IndexIntent
    
    init(viewModel: IndexViewModel){
        self.festival = viewModel
        self.indexIntent = IndexIntent(model: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Text(festival.nomFestival)
                Text("Du \(festival.dateDebut) au \(festival.dateFin) mars")
                NavigationLink(destination: FestivalItemView()){
                        Text("Plus d'infos")
                    }
                HStack{
                    NavigationLink(destination: UserListView(viewModel: UserListViewModel(users: []))){
                            Text("Bénévoles")
                        }
                    NavigationLink(destination: UserListView(viewModel: UserListViewModel(users: []))){
                            Text("Zones")
                        }
                }
            }
            Text("A découvrir")
            VStack{
                HStack{
                    Text("1000")
                    Text("Bénévoles répartis sur tous les festivals")
                }
                HStack{
                    Text("200")
                    Text("Festivals")
                }
                NavigationLink(destination: UserListView(viewModel: UserListViewModel(users: []))){
                        Text("Découvrir tous les festivals")
                    }
            }
        }
    }
}

