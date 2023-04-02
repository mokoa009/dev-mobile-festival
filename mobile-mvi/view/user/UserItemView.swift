//
//  UserItemView.swift
//
//  Created by garcy on 13/02/2023.
//
import Foundation
import SwiftUI

struct UserItemView: View {
    @ObservedObject var user: UserViewModel
    
    init(user: UserViewModel) {
        self.user = user
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text(user.nom)
            Text(user.prenom)
            Text(user.email)
        }
    }
}
