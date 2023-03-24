//
//  FestivalListView.swift
//  mobile-mvi
//
//  Created by etud on 22/03/2023.
//

import Foundation
import SwiftUI

struct FestivalListView : View {
    
    @ObservedObject var festivals : FestivalListViewModel
    var festivalIntent : FestivalIntent
    
    init(viewModel : FestivalListViewModel){
        self.festivals = viewModel
        self.festivalIntent = FestivalIntent(model: viewModel)
    }
    
    
    var body : some View {
        Text("Festivals")
        Text("test")
        
        NavigationStack{
            VStack {
                List{
                    ForEach(festivals.festivals, id: \.self) { festival in
                        NavigationLink(value: festival){
                            FestivalItemView(festival: festival)
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
                await festivalIntent.getFestivals()
        }
    }
}

