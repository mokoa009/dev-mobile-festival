//
//  ConnexionViewModel.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import Foundation
import SwiftUI
import JWTDecode

class ConnexionViewModel : ObservableObject{//, UserModelObserver {
    
    @Published var mdp : String
    @Published var email : String
    
    init() {
        self.mdp = ""
        self.email = ""
    }
    // -----------------------------------------------------------
    // State Intent management
    @Published var state : ConnexionState = .ready {
        didSet {
            switch state {
                case .error:
                    debugPrint("error")
                    self.state = .ready
                case .ready:
                    debugPrint("ConnexionViewModel: ready state")
                    debugPrint("-------------------------------")
                case .connexion:
                    debugPrint("connexion")
                case .authentification:
                    debugPrint("connexion en cours")
                case .authentified:
                    debugPrint("connecté")
                default:
                    break
                }
        }
    }
}

