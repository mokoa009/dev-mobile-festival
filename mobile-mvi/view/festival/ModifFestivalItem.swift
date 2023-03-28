//
//  ModifFestivalItem.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct ModifFestivalItem: View {
    
    @ObservedObject var festival : ModifFestivalItemViewModel
    var festivalIntent : ModifFestivalIntent
    
    
    init(viewModel: ModifFestivalItemViewModel){
        self.festival = viewModel
        self.festivalIntent = ModifFestivalIntent(model: viewModel)
    }
    
    var body: some View {
        Text("test")
        Text("test")
    }
    
}
