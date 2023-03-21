//
//  ContentView.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import SwiftUI

struct ContentView : View {
    
    var body: some View {
        Text("TEST OUIIIII")
            .padding()
            .onAppear(){
                debugPrint("AHHHHHHHHHHHHHHHHHHHHHHHHHHHh")
            }
     
        UserListView(viewModel: UserListViewModel(users: []))
        
    }
    
}

struct ContentViewList_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
