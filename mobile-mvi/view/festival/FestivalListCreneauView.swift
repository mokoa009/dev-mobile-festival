//
//  FestivalListCreneauView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//


import Foundation
import SwiftUI

struct FestivalListCreneauView : View {
    
    @ObservedObject var creneaux : FestivalListCreneauViewModel
    var festivalCreneauIntent : FestivalCreneauIntent

    
    init(viewModel : FestivalListCreneauViewModel){
        self.creneaux = viewModel
        self.festivalCreneauIntent = FestivalCreneauIntent(model: viewModel)
    }
    
    var body : some View {
        VStack {
            ForEach(creneaux.creneaux, id: \.self) { creneau in
                HStack{
                    Text("\(creneau.heureDebut) - \(creneau.heureFin)")
                    Button("*", action: {
                        debugPrint("supprimer creneau")
                        /*Task{
                            await supprimerUser(id: user.id)
                        }*/
                    })
                    Spacer()
                    Button("+", action: {
                        debugPrint("voir benevole")
                        /*Task{
                            await supprimerUser(id: user.id)
                        }*/
                    })
                }
            }
        }.task {
            await festivalCreneauIntent.getCreneaux(idJour: creneaux.idJour)
        }
    }
}
