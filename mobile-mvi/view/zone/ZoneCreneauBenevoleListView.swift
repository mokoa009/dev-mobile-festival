//
//  BenevoleCreneauZoneListView.swift
//  mobile-mvi
//
//  Created by garcy on 27/03/2023.
//

import Foundation
import SwiftUI

struct ZoneCreneauBenevoleListView : View {
    
    @EnvironmentObject var tokenManager: Token
    @ObservedObject var zones : ZoneCreneauBenevoleListViewModel
    var zoneCreneauBenevoleIntent : ZoneCreneauBenevoleIntent
    @State var benevoleSelect : UserViewModel
    
    init(viewModel : ZoneCreneauBenevoleListViewModel){
        self.zones = viewModel
        self.zoneCreneauBenevoleIntent = ZoneCreneauBenevoleIntent(model: viewModel)
        self.benevoleSelect = UserViewModel(id: -1, nom: "", prenom: "", email: "")
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
                                    await zoneCreneauBenevoleIntent.deleteZoneCreneauBenevole(idBenevole:benevole.id, token: tokenManager.token?.string)
                                }
                            })
                        }.buttonStyle(.bordered)
                    }
                }
                Text("Nbr bénévole actuel A REMPLIR : 2")
                Text("Nbr bénévole manquant A REMPLIR : 2")
               
                Picker(selection: $benevoleSelect, label : Text("Bénévoles")){
                    ForEach(zones.benevolesNonAffecte, id:\.self){ benevole in
                        Text("Id : \(benevole.id), Nom : \(benevole.nom), Prenom : \(benevole.prenom), Email :  \(benevole.email)").tag(benevole)
                        }
                    }.task() {
                            await zoneCreneauBenevoleIntent.getBenevolesNonAffect()
                    }
                    .onChange(of: benevoleSelect){ newBenevole in
                        debugPrint("change change")
                        debugPrint(benevoleSelect.email)
                        debugPrint(newBenevole.email)
                        Task{
                            await zoneCreneauBenevoleIntent.affecterZoneCreneauBenevole(utilisateur: newBenevole,token: tokenManager.token?.string)
                        }
                    }
            }
        }.task {
            await zoneCreneauBenevoleIntent.getBenevoles()
        }
    }
}

