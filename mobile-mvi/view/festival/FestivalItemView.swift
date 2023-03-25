//
//  FestivalItemView.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import SwiftUI

struct FestivalItemView: View {
    @ObservedObject var festival: FestivalViewModel
    
    init(festival: FestivalViewModel) {
        self.festival = festival
    }
    
    var body: some View {
        Text(festival.nom)
        Text(festival.annee)
        Text(String(festival.nbJours))
    }
}
