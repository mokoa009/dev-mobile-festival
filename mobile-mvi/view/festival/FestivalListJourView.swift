//
//  FestivalJourView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListJourView : View {
    
    let id = UUID()
    @ObservedObject var jours : FestivalListJourViewModel
    var festivalJourIntent : FestivalJourIntent

    
    init(viewModel : FestivalListJourViewModel){
        self.jours = viewModel
        self.festivalJourIntent = FestivalJourIntent(model: viewModel)
    }

    var body : some View {
        ScrollView{
            VStack(alignment: .center) {
                    Text("Liste des jours du festival").font(.title)
                    ForEach(jours.jours, id: \.self) { jour in
                        VStack{
                            Text("Nom: \(jour.nom)")
                            Text("Heure ouverture : \(jour.ouverture)")
                            Text("Heure fermeture : \(jour.fermeture)")
                            //list zones
                            VStack{
                                NavigationLink(destination: FestivalListCreneauView(viewModel: FestivalListCreneauViewModel(zonesCreneaux: [], idJour: jour.idJour))
                                ){
                                    Label("", systemImage:  "eye").foregroundColor(.blue)
                                }
                            }
                        }.padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black)
                            )
                            .foregroundColor(.black)
                    }
                }.task {
                    await festivalJourIntent.getJours(id: jours.idFestival)
                }//.background(.black).foregroundColor(.green)
        }
    }
}
