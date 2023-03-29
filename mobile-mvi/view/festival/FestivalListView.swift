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
    
    func cloturerFestival(id : Int) async{
        await festivalIntent.clotureFestival(id: id)
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
                                if (Token.isAdmin()) {
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
                                        if (!festival.cloture){
                                            
                                            NavigationLink(
                                                destination: ModifFestivalItem(viewModel: ModifFestivalItemViewModel(id: festival.id)),
                                                label: {Label("", systemImage:  "square.and.pencil")}
                                            )

                                            Spacer()
                                            Button(action: {
                                                Task{
                                                    await cloturerFestival(id: festival.id)
                                                }
                                            }){
                                                Image(systemName: "xmark").foregroundColor(.green)
                                            }
                                        } else {
                                            Button(action : {}){
                                                Text("CLOTURÉ").foregroundColor(.red)
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                }
                                
                            }.foregroundColor(Color.white)
                            Spacer()
                            
                        }
                    }.listRowBackground(Color.black)

                    NavigationLink(destination: AjoutFestivalItem(viewModel: AjoutFestivalViewModel())) {

                        HStack{
                            Spacer()
                            Text("  Ajouter festival").foregroundColor(.green)
                            Spacer()
                        }
                        
                    }.frame( maxWidth: .infinity ,maxHeight: .infinity).background(.black)

                    
                }.buttonStyle(.bordered).background(.black)
            }.background(.red)
        }.task {
            await festivalIntent.getFestivals()
        }
    }
}
