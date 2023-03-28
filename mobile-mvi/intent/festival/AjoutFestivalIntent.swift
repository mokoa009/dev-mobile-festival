//
//  AjoutFestivalIntent.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct AjoutFestivalIntent {
    
    @ObservedObject private var model : AjoutFestivalViewModel
    
    init(model: AjoutFestivalViewModel){
        self.model = model
    }
}
