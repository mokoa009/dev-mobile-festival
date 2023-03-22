//
//  UserListView.swift
//  mobile-mvi
//
//  Created by garcy on 20/03/2023.
//
import Foundation
import SwiftUI

struct UserListView : View {
    
    @ObservedObject var users : UserListViewModel
    var userIntent : UserIntent
    
    init(viewModel : UserListViewModel){
        self.users = viewModel
        self.userIntent = UserIntent(model: viewModel)
    }
    
    
    var body : some View {
        Text("BOBOBLO")
        NavigationStack{
            VStack {
                List{
                    ForEach(users.users, id: \.self) { user in
                        NavigationLink(value: user){
                            UserItemView(user: user)
                        }
                    }
                }
            }
        //}.onAppear(){
          //  debugPrint("chargement data ?")
          //  Task{
           //     await userIntent.getUsers(of: users)
         //   }
        }.task {
            debugPrint("chargement data ?")
                await userIntent.getUsers()
        }
    }
}
