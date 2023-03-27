//
//  BenevoleCreneauZoneListView.swift
//  mobile-mvi
//
//  Created by garcy on 27/03/2023.
//

import Foundation
import SwiftUI

struct ZoneCreneauBenevoleListView : View {
    
    @ObservedObject var zones : ZoneCreneauBenevoleListViewModel
    var zoneCreneauBenevoleIntent : ZoneCreneauBenevoleIntent
    
    init(viewModel : ZoneCreneauBenevoleListViewModel){
        self.zones = viewModel
        self.zoneCreneauBenevoleIntent = ZoneCreneauBenevoleIntent(model: viewModel)
    }
    var body : some View {
        NavigationStack{
            VStack {
                Text("Affectation bénévoles")
                Text("Vous avez sélectionné le créneau 15-17 pour la zone 2")
                ForEach(zones.benevoles, id: \.self) { benevole in
                    VStack{
                        UserItemView(user: benevole)
                        HStack{
                            Button("Supprimer", action: {
                                Task{
                                    await zoneCreneauBenevoleIntent.deleteZoneCreneauBenevole(idBenevole:benevole.id)
                                }
                            })
                        }.buttonStyle(.bordered)
                    }
                }
                Text("Nbr bénévole actuel A REMPLIR : 2")
            }
        }.task {
            await zoneCreneauBenevoleIntent.getBenevoles()
        }
    }
}

