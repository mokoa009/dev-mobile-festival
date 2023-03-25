//
//  TrackViewModel.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

class UserViewModel : ObservableObject, Hashable, Equatable{//, UserModelObserver {
    
    @Published var id : Int
    @Published var nom : String
    @Published var prenom : String
    @Published var email : String
    
    init(id: Int, nom: String, prenom: String, email: String) {
        self.id = id
        self.nom = nom
        self.prenom = prenom
        self.email = email
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : UserState = .ready {
        didSet {
            switch state {
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("UserViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
    
    static func == (lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
