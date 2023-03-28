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
    var ajoutFestivalIntent : AjoutFestivalIntent
    
    init(viewModel: AjoutFestivalViewModel){
        self.ajoutFestival = viewModel
        self.ajoutFestivalIntent = AjoutFestivalIntent(model: viewModel)
    }
    
    var body: some View {
        Text("test")
        Text("test")
    }

}
