//
//  AjoutFestivalItem.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct ModifFestivalItem : View{
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var modifFestival : ModifFestivalItemViewModel
    @State var dateDebut : Date  = Date()
    @State var dateFin : Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    var modifFestivalIntent : ModifFestivalIntent
    
    init(viewModel: ModifFestivalItemViewModel){
        self.modifFestival = viewModel
        self.modifFestivalIntent = ModifFestivalIntent(model: viewModel)
    }
    
    var body: some View {
        VStack{
            Text("Modifier le Festival").font(.title)
            
            TextField(text: $modifFestival.nom){
                Text("Nom du Festival : *")
            }.textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            
            DatePicker("  Date de début", selection: $dateDebut, displayedComponents: .date)
                .padding(5)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 5))
                .foregroundColor(.black).accentColor(.red)
            
            let lendemain = Calendar.current.date(byAdding: .day, value: 1, to: dateDebut)!
            
            DatePicker("  Date de fin", selection: $dateFin, in : lendemain..., displayedComponents: .date)
                .padding(5)
                .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 5))
                .foregroundColor(.black).accentColor(.red)
        }//.frame(maxHeight: .infinity).background(.black).foregroundColor(.green)
    }

}
