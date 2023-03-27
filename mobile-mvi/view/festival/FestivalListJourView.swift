//
//  FestivalJourView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListJourView : View {
    
    @ObservedObject var jours : FestivalListJourViewModel
    var festivalJourIntent : FestivalJourIntent

    
    init(viewModel : FestivalListJourViewModel){
        self.jours = viewModel
        self.festivalJourIntent = FestivalJourIntent(model: viewModel)
    }
    
    /*
    func supprimerUser(id : Int) async{
        await userIntent.deleteUser(id: id)
    }*/
    

    var body : some View {
        VStack {
                ForEach(jours.jours, id: \.self) { jour in
                    VStack{
                        Text("1/02/2000")
                        Text(jour.nom)
                        //list creneau
                        VStack{
                            Text(jour.ouverture)
                            VStack{
                                FestivalListCreneauView(viewModel:FestivalListCreneauViewModel(creneaux: [], idJour: jour.idJour))
                            }
                            Text(jour.fermeture)
                        }
                    }.padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.pink)
                        )
                }
                
            }.task {
                await festivalJourIntent.getJours(id: jours.idFestival)
            }
            Button("AJouter un créneau", action: {
                debugPrint("ajout creneau")
                /*Task{
                    await supprimerUser(id: user.id)
                }*/
            })
    }
}
