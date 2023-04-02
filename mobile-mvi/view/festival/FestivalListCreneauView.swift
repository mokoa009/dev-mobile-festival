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
                                Button("*", action: {
                                    debugPrint("supprimer creneau")
                                    /*Task{
                                        await supprimerUser(id: user.id)
                                    }*/
                                })
                                Button("+", action: {
                                    debugPrint("voir benevole")
                                    /*Task{
                                        await supprimerUser(id: user.id)
                                    }*/
                                })
                            }
                        }
                    }
                }
            }
        }.task() {
            await festivalCreneauIntent.getCreneauxZones(idJour: creneauxZones.idJour)
        }//.buttonStyle(.bordered).background(.black)
    }
}
