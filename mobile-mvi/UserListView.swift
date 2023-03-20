//
//  UserListView.swift
//  mobile-mvi
//
//  Created by garcy on 20/03/2023.
//
import Foundation
import SwiftUI

struct UserListView : View {
    
    @ObservedObject var users = UserListViewModel(users: [])
    var userIntent = UserIntent()
    
    
    var body : some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(users.users, id: \.self) { user in
                        NavigationLink(value: user){
                            UserItemView(user: user)
                        }
                    }.onAppear(){
                        debugPrint("chargement data ?")
                        Task{
                            await userIntent.getUsers(of: users)
                        }
                    }
                }
            }
        }
    }
}
