//
//  FestivalListZoneView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListZoneView : View {
    
    let id = UUID()
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var zones : FestivalListZoneViewModel
    var festivalZoneIntent : FestivalZoneIntent

    
    init(viewModel : FestivalListZoneViewModel){
        self.zones = viewModel
        self.festivalZoneIntent = FestivalZoneIntent(model: viewModel)
    }

    var body : some View {
        VStack {
                ForEach(zones.zones, id: \.self) { zone in
                    VStack{
                        Text("Zone n°\(zone.idZone)")
                        Text("Nom: \(zone.nom)")
                        Text("Nombres de bénévoles affectés sur la zone : \(zone.nbBenevoles)")
                    }.padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.black)
                        )
                        .foregroundColor(.black)
                }
            Button("AJouter une zone", action: {
                debugPrint("ajout zone")
                /*Task{
                    await supprimerUser(id: user.id)
                }*/
            })
                
            }.task {
                await festivalZoneIntent.getZones(id: zones.idJour)
            }//.frame(maxHeight: .infinity).background(.black).foregroundColor(.green)
    }
}
