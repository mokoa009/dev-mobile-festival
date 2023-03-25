//
//  ProfilIntent.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation
import SwiftUI

struct ProfilIntent {
    
    @ObservedObject private var model : ProfilViewModel
    
    init(model: ProfilViewModel){
        self.model = model
    }
    
    func update() async {
        self.model.state = .updateUser
        
        guard let url = URL(string:"https://dev-festival-api.cluster-ig4.igpolytech.fr/utilisateurs/update") else {
            debugPrint("bad url getUser")
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "PUT"
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requete.addValue("Bearer "+Token.getToken(),forHTTPHeaderField:"Authorization")
            requete.addValue("*/*",forHTTPHeaderField: "Accept")
            
            //convertion Int -> Bool
            let isAdmin : Int
            if(model.isAdmin){
                isAdmin = 1
            }else{
                isAdmin = 0
            }
            //creation body requete
            let body : UserDTO
            if(model.nouveauMdp != ""){
                body = UserDTO(idUtilisateur: model.id, nom: model.nom, prenom: model.prenom, email: model.email, mdp: model.nouveauMdp, isAdmin: isAdmin)
            }else{
                body = UserDTO(idUtilisateur: model.id, nom: model.nom, prenom: model.prenom, email: model.email, isAdmin: isAdmin)
            }
            
            guard let encoded = await JSONHelper.encode(data: body) else {
                print("pb encodage")
                self.model.state = .error
                return
            }
            requete.httpBody = encoded
            let (_, response) = try await URLSession.shared.data(for: requete)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                model.state = .updated
                model.state = .ready
            }
            else{
                debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                self.model.state = .error
            }
        }
        catch{
            debugPrint("bad request")
            self.model.state = .error
        }
    }
    func getUserById(id: Int) async {
        self.model.state = .loadUser
        
        guard let url = URL(string:"https://dev-festival-api.cluster-ig4.igpolytech.fr/utilisateurs/profil/"+String(id)) else {
            debugPrint("bad url getUser")
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "GET"
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requete.addValue("Bearer "+Token.getToken(),forHTTPHeaderField:"Authorization")
            requete.addValue("*/*",forHTTPHeaderField: "Accept")
            
            let (data, response) = try await URLSession.shared.data(for: requete)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                guard let decoded : [UserDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                model.state = .loadedUser(decoded[0].convertToUser())
            }
            else{
                debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                self.model.state = .error
            }
        }
        catch{
            debugPrint("bad request")
            self.model.state = .error
        }
    }
}
