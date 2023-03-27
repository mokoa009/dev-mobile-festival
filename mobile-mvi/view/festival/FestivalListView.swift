//
//  FestivalList.swift
//  mobile-mvi
//
//  Created by etud on 27/03/2023.
//
//
import Foundation
import SwiftUI

struct FestivalListView : View {
    
    @ObservedObject var festivals : FestivalListViewModel
    var festivalIntent : FestivalIntent
    
    init(viewModel : FestivalListViewModel){
        self.festivals = viewModel
        self.festivalIntent = FestivalIntent(model: viewModel)
    }
    
    func supprimerFestival(id : Int) async{
        await festivalIntent.deleteFestival(id: id)
    }
    
    
    
    func modifierFestival(){
        debugPrint("modifier festival")
    }
    var body : some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(festivals.festivals, id: \.self) { festival in
                        VStack{
                            Text("Festival n° \(festival.id)")
                            Text("Nom : " + festival.nom)
                            Text("Annee : " + String(festival.annee))
                            Text("nbJours : \(festival.nbJours)")
                            HStack{
                                Button("Supprimer", action: {
                                    Task{
                                        await supprimerFestival(id: festival.id)
                                    }
                                })
                                Button("Modifer", action: modifierFestival)
                            }.buttonStyle(.bordered)
                        }
                    }
                }
            }
        }.task {
            await festivalIntent.getFestivals()
        }
    }
}
