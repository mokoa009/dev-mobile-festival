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
                        HStack {
                            Spacer()
                            VStack(){
                                Text("Festival n° \(festival.id)").font(Font.title)
                                Image(systemName: "gamecontroller.fill").foregroundColor(.green).font(.title)
                                Text("Nom : " + festival.nom)
                                Text("Annee : " + String(festival.annee))
                                Text("Durée : \(festival.nbJours)")
                                HStack{
                                    Spacer()
                                    Button(action: {
                                        Task{
                                            await supprimerFestival(id: festival.id)
                                        }
                                    }){
                                        Image(systemName: "trash").foregroundColor(.green)
                                    }
                                    Spacer()
                                    Button(action: modifierFestival){
                                        Image(systemName: "pencil").foregroundColor(.green)
                                    }
                                    Spacer()
                                }.buttonStyle(.bordered)
                            }.foregroundColor(Color.white)
                            Spacer()
                            
                        }
                    }.listRowBackground(Color.black)
                }
            }.background(.red)
        }.task {
            await festivalIntent.getFestivals()
        }
    }
}
