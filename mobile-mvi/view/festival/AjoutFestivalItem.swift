//
//  AjoutFestivalItem.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct AjoutFestivalItem : View{
    
    @EnvironmentObject var tokenManager : Token
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var ajoutFestival : AjoutFestivalViewModel
    @State var dateDebut : Date  = Date()
    @State var dateFin : Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
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
            
            let lendemain = Calendar.current.date(byAdding: .day, value: 1, to: dateDebut)!
            
            DatePicker("  Date de fin", selection: $dateFin, in : lendemain..., displayedComponents: .date)
                .padding(5)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 5))
                .foregroundColor(.green).accentColor(.green)
            
            Button("Envoyer", action : {
                debugPrint(ajoutFestival.nom)
                Task{
                    await ajoutFestivalIntent.ajouterFestival(nom: ajoutFestival.nom, dateDebut: dateDebut, dateFin: dateFin,token: tokenManager.token?.string)
                }
                dismiss()
            })
        }//.frame(maxHeight: .infinity).background(.black).foregroundColor(.green)
    }

}
