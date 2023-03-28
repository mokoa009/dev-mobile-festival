//
//  ModifFestivalIntent.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct ModifFestivalIntent {
    
    @ObservedObject private var model : ModifFestivalItemViewModel
    
    init(model: ModifFestivalItemViewModel){
        self.model = model
    }
}
