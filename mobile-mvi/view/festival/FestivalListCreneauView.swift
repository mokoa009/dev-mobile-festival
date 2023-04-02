//
//  FestivalListCreneauView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//


import Foundation
import SwiftUI

struct FestivalListCreneauView : View {
    
    let id = UUID()
    @EnvironmentObject var tokenManager : Token
    @ObservedObject var creneauxZones : FestivalListCreneauViewModel
    var festivalCreneauIntent : FestivalCreneauIntent

    
    init(viewModel : FestivalListCreneauViewModel){
        self.creneauxZones = viewModel
        self.festivalCreneauIntent = FestivalCreneauIntent(model: viewModel)
    }
    
    var body : some View {
        VStack {
            ForEach(creneauxZones.zonesCreneaux, id: \.self) { zone in
                VStack{
                    Text("Zone n°\(zone.idZone)")
                    Text("Nom: \(zone.nom)")
                    Text("Nombres de bénévoles affectés :\(zone.nbBenevoles)")
                    ForEach(zone.creneaux, id: \.self){ creneau in
                        if(creneau.id != -1){
                            HStack{
                                Text("\(creneau.heureDebut) h --  \(creneau.heureFin)h")
                                if(tokenManager.isAdmin()){
                                    Button(action: {
                                        Task{
                                            await festivalCreneauIntent.supprimerCreneau(creneau: creneau,idZone:zone.idZone,idJour:creneauxZones.idJour, token:tokenManager.token?.string)
                                        }
                                    }){
                                        Image(systemName: "xmark").foregroundColor(.red)
                                    }
                                    NavigationLink(destination: ZoneCreneauBenevoleListView(viewModel: ZoneCreneauBenevoleListViewModel(benevoles: [], idZone: zone.idZone, idCreneau: creneau.id, idJour:creneauxZones.idJour, benevolesNonAffecte: []))
                                    ){
                                        Label("", systemImage:  "person.crop.circle").foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    }
                }.padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.black)
                    )
                    .foregroundColor(.black)
            }
        }.task() {
            await festivalCreneauIntent.getCreneauxZones(idJour: creneauxZones.idJour)
        }//.frame(maxHeight: .infinity).background(.black).foregroundColor(.green)
    }
}
