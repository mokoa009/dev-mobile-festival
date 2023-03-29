//
//  AjoutFestivalItem.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct AjoutFestivalItem : View{
    
    @ObservedObject var ajoutFestival : AjoutFestivalViewModel
    @State var dateDebut : Date  = Date()
    @State var dateFin : Date  = Date()
    var ajoutFestivalIntent : AjoutFestivalIntent
    
    init(viewModel: AjoutFestivalViewModel){
        self.ajoutFestival = viewModel
        self.ajoutFestivalIntent = AjoutFestivalIntent(model: viewModel)
    }
    
    var body: some View {
        VStack{
            Text("Ajout Festival").font(.title)
            
            TextField(text: $ajoutFestival.nom){
                Text("Nom du Festival : *")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            DatePicker("  Date de début", selection: $dateDebut, displayedComponents: .date)
                .padding(5)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 5))
                .foregroundColor(.green).accentColor(.green)
            
            DatePicker("  Date de fin", selection: $dateFin, displayedComponents: .date)
                .padding(5)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 5))
                .foregroundColor(.green).accentColor(.green)
            
            Button("Envoyer", action : {
                debugPrint(ajoutFestival.nom)
                debugPrint(ajoutFestival.annee)
//                Task{
//                    await connexionIntent.connexion()
//                }
            })
        }.frame(maxHeight: .infinity).background(.black).foregroundColor(.green)
    }

}
