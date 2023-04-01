//
//  CreneauFormView.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct CreneauFormView : View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var tokenManager: Token
    @ObservedObject var creneau : CreneauFormViewModel
    var creneauFormIntent : CreneauFormIntent
    var idJour : Int
    
    init(viewModel: CreneauFormViewModel, idJour : Int){
        self.creneau = viewModel
        self.creneauFormIntent = CreneauFormIntent(model: viewModel)
        self.idJour = idJour
    }
    
    var body: some View {
        VStack{
            VStack{
                Text("Affectation d'un nouveau créneau")
                TextField(text: $creneau.heureDebut){
                    Text("Heure début :")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                TextField(text: $creneau.heureFin){
                    Text("Heure fin :")
                }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            }
            Button("Ajouter le créneau", action : {
                Task{
                    await creneauFormIntent.createCreneauJour(idJour : self.idJour,token: tokenManager.token?.string)
                    dismiss()
                }
            })
        }
    }
}

