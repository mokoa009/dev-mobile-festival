//
//  FestivalListView.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListView : View {
    
    @ObservedObject var Festivals : FestivalListViewModel
    var FestivalIntent : FestivalIntent
    
    init(viewModel : FestivalListViewModel){
        self.Festivals = viewModel
        self.FestivalIntent = FestivalIntent(model: viewModel)
    }
    
    
    var body : some View {
        Text("BOBOBLO")
        NavigationStack{
            VStack {
                List{
                    ForEach(Festivals.Festivals, id: \.self) { Festival in
                        NavigationLink(value: Festival){
                            FestivalItemView(Festival: Festival)
                        }
                    }
                }
            }
        //}.onAppear(){
          //  debugPrint("chargement data ?")
          //  Task{
           //     await FestivalIntent.getFestivals(of: Festivals)
         //   }
        }.task {
            debugPrint("chargement data ?")
                await FestivalIntent.getFestivals()
        }
    }
}

