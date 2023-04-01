//
//  UserNonAffecteViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 29/03/2023.
//

import Foundation

class UserNonAffecteListViewModel : ObservableObject{
    
    @Published var users : [UserViewModel]
    @Published var idZone : Int
    @Published var idCreneau: Int
    // @Published var userSelect : UserViewModel? = nil
    @Published var benevoles : [UserViewModel]
    
    init(users: [UserViewModel],idZone : Int, idCreneau : Int, benevoles: [UserViewModel]) {
        self.users = users
        self.idZone = idZone
        self.idCreneau = idCreneau
        self.benevoles = benevoles
        debugPrint("benevolesLMUNA")
        
    }
    
    func change(name: String) {
        self.objectWillChange.send()
    }
    
    func remove(atOffsets indexSet : IndexSet) {
        self.users.remove(atOffsets: indexSet)
        self.objectWillChange.send()
    }
    
    func move(fromOffsets indexSet : IndexSet, toOffset index: Int) {
        self.users.move(fromOffsets: indexSet, toOffset: index)
        self.objectWillChange.send()
    }
    @Published var state : UserNonAffecteState = .ready {
        didSet {
            switch state {
            case .loadingUsers:
                debugPrint("state loading UserNonAffecVM")
            case .loadedUsers(let newUsers):
                //transformation UserDTO en UserViewModel
                self.users = newUsers.map{ user in user.convertToUserVM()}
                debugPrint("jai charge les donnees")
                self.state = .ready
            case .benevoleAffected(let userSelected):
                debugPrint("benevoleAffeted")
                //mettre à jour les users de l'autre model
                self.benevoles.append(userSelected)
                debugPrint("state bene")
                debugPrint(self.benevoles)
                self.state = .ready
            case .error:
                debugPrint("error")
                self.state = .ready
            case .ready:
                debugPrint("UserListViewModel: ready state")
                debugPrint("--------------------------------------")
            default:
                break
            }
        }
    }
}
