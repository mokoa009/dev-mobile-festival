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
  //  @Published var isAdmin : String
  //  @Published var mdp : String
    
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
    
    init(user : UserDTO) {
        self.id = user.idUtilisateur
        self.nom = user.nom
        self.prenom = user.prenom
        self.email = user.email
    }
}
