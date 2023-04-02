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
    
    @EnvironmentObject var tokenManager : Token
    @ObservedObject var festivals : FestivalListViewModel
    var festivalIntent : FestivalIntent
    @State private var festivalSelected: FestivalViewModel?
    
    init(viewModel : FestivalListViewModel){
        self.festivals = viewModel
        self.festivalIntent = FestivalIntent(model: viewModel)
    }
    
    func supprimerFestival(id : Int) async{
        await festivalIntent.deleteFestival(id: id,token: tokenManager.token?.string)
    }
    
    func cloturerFestival(id : Int) async{
        await festivalIntent.clotureFestival(id: id,token: tokenManager.token?.string)
    }
    
    var body : some View {
        NavigationStack{
            VStack {
                
                    ForEach(festivals.festivals, id: \.self) { festival in
                        HStack {
                            Spacer()
                            VStack(){
                                Text("Festival n° \(festival.id)").font(Font.title)
                                Image(systemName: "gamecontroller.fill").foregroundColor(.green).font(.title)
                                Text("Nom : " + festival.nom)
                                Text("Année : " + String(festival.annee))
                                Text("Durée : \(festival.nbJours) jours")
                                NavigationLink(destination: FestivalListJourView(viewModel: FestivalListJourViewModel(jours: [], idFestival: festival.id))
                                ){
                                    Label("", systemImage:  "eye").foregroundColor(.green)
                                }
                                if (tokenManager.isAdmin()) {
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
                                            /*
                                            NavigationLink(
                                                destination: ModifFestivalItem(viewModel: ModifFestivalItemViewModel(id: festival.id)),
                                                label: {Label("", systemImage:  "square.and.pencil")}
                                            )*/

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
                    NavigationLink(destination: AjoutFestivalItem(viewModel: AjoutFestivalViewModel(list: self.festivals))) {

                        HStack{
                            Spacer()
                            Text("  Ajouter festival").foregroundColor(.green)
                            Spacer()
                        }
                        
                    }.frame( maxWidth: .infinity ,maxHeight: .infinity).background(.black)

                    
                //}.buttonStyle(.bordered).background(.black)
            }.buttonStyle(.bordered).background(.black)
        }.task {
            await festivalIntent.getFestivals()
        }
    }
}
