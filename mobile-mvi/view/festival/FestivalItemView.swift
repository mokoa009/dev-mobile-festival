//
//  FestivalItemView.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @ObservedObject var Festival: FestivalViewModel
    
    init(Festival: FestivalViewModel) {
        self.Festival = Festival
    }
    
    var body: some View {
        Text(Festival.nom)
        //rajouter attributs Festival
    }
}
