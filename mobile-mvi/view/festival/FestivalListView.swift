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
            ScrollView{
                VStack(alignment: .center) {
                        Text("ERIMA FESTIVALS").font(.title)
                        ForEach(festivals.festivals, id: \.self) { festival in
                            HStack {
                                Spacer()
                                VStack(){
                                    Text("Festival n° \(festival.id)").font(Font.title)
                                    Image(systemName: "gamecontroller.fill").foregroundColor(.black).font(.title)
                                    Text("Nom : " + festival.nom)
                                    Text("Année : " + String(festival.annee))
                                    Text("Durée : \(festival.nbJours) jours")
                                    NavigationLink(destination: FestivalListJourView(viewModel: FestivalListJourViewModel(jours: [], idFestival: festival.id))
                                    ){
                                        Label("", systemImage:  "eye").foregroundColor(.blue)
                                    }
                                    if (tokenManager.isAdmin()) {
                                        HStack{
                                            Spacer()
                                            Button(action: {
                                                Task{
                                                    await supprimerFestival(id: festival.id)
                                                }
                                            }){
                                                Image(systemName: "trash").foregroundColor(.black)
                                            }
                                            Spacer()
                                            if (!festival.cloture){
                                                Spacer()
                                                Button(action: {
                                                    Task{
                                                        await cloturerFestival(id: festival.id)
                                                    }
                                                }){
                                                    Image(systemName: "xmark").foregroundColor(.black)
                                                }
                                            } else {
                                                Button(action : {}){
                                                    Text("CLOTURÉ").foregroundColor(.red)
                                                }
                                            }
                                            
                                            Spacer()
                                        }
                                    }
                                    
                                }.padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.black)
                                    )
                                    .foregroundColor(.black)
                                Spacer()
                                
                            }
                        }.listRowBackground(Color.black)
                        if(tokenManager.isAdmin()){
                            NavigationLink(destination: AjoutFestivalItem(viewModel: AjoutFestivalViewModel(list: self.festivals))) {

                                HStack{
                                    Spacer()
                                    Text("  Ajouter festival")
                                    Spacer()
                                }
                                
                            }//.frame( maxWidth: .infinity ,maxHeight: .infinity).background(.black)
                        }
                }//.buttonStyle(.bordered).background(.black)
            }.task {
                await festivalIntent.getFestivals()
            }
            }
            
    }
}
