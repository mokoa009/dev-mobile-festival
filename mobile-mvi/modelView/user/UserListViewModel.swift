//
//  UserDTOListViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 20/03/2023.
//

import Foundation

class UserListViewModel : ObservableObject, UserModelObserver {
    
    @Published var users : [UserViewModel]
    
    init(users: [UserViewModel]) {
        self.users = users
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
    @Published var state : UserState = .ready {
        didSet {
            switch state {
                case .loadingUsers:
                    debugPrint("state loading UserVM")
                case .loadedUsers(let newUsers):
                    //transformation UserDTO en UserViewModel
                    self.users = newUsers.map{ user in user.convertToUserVM()}
                    self.state = .ready
                case .error:
                    debugPrint("error")
                    self.state = .ready
                case .deletingUser:
                    debugPrint("demande delete user")
                case .deleted(let userDeleted):
                    //remove premiere occurence de l'user deleted
                    self.users.remove(at:self.users.firstIndex(of:userDeleted)!)
                    
                case .ready:
                    debugPrint("UserListViewModel: ready state")
                    debugPrint("--------------------------------------")
                default:
                    break
                }
        }
    }
}
