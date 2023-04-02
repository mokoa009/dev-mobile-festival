//
//  ZoneListView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct ZoneListView : View {
    
    @EnvironmentObject var tokenManager: Token
    @ObservedObject var zones : ZoneListViewModel
    var zoneIntent : ZoneIntent
    
    init(viewModel : ZoneListViewModel){
        self.zones = viewModel
        self.zoneIntent = ZoneIntent(model: viewModel)
    }
    
    func supprimerZone(id : Int) async{
        await zoneIntent.deleteZone(id: id,token: tokenManager.token?.string)
    }
    
    var body : some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(zones.zones, id: \.self) { zone in
                        VStack{
                            Text("Zone n° \(zone.id)")
                            Text("Nom : " + zone.nom)
                            Text("Capacité : \(zone.nbBenevoles)")
                            Text("Nbr bénévole actuel A REMPLIR : 2")
                            HStack{
                                Button("Supprimer", action: {
                                    Task{
                                        await supprimerZone(id: zone.id)
                                    }
                                })
                            }.buttonStyle(.bordered)
                        }
                    }
                }
            }
        }.task {
            await zoneIntent.getZones(idFestival: zones.idFestival)
        }
    }
}
