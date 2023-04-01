//
//  TrackIntent.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation
import SwiftUI


struct UserIntent {
    
    @ObservedObject private var model : UserListViewModel
    
    init(model: UserListViewModel){
        self.model = model
    }
    
    func getUsers() async {
        self.model.state = .loadingUsers
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/utilisateurs") else {
            debugPrint("bad url getUser")
            self.model.state = .error
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "GET"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: requete)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                guard let decoded : [UserDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                model.state = .loadedUsers(decoded)
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


    func deleteUser(id: Int, token: String?) async {
        self.model.state = .deleteUser
        if(token != nil){
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/utilisateurs/delete") else {
                debugPrint("bad url getUser")
                return
            }
            do{
                var requete = URLRequest(url: url)
                requete.httpMethod = "DELETE"
                //append a value to a field
                requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
                requete.addValue("Bearer "+token!,forHTTPHeaderField:"Authorization")
                requete.addValue("*/*",forHTTPHeaderField: "Accept")
                
                let body = [
                    "idUtilisateur":id
                ]
                guard let encoded = await JSONHelper.encode(data: body) else {
                    print("pb encodage")
                    self.model.state = .error
                    return
                }
                requete.httpBody = encoded
                let (_, response) = try await URLSession.shared.data(for: requete)
                let httpresponse = response as! HTTPURLResponse
                if httpresponse.statusCode == 200{
                    model.state = .deleted
                    // virer l'utilisateur dans le view model donc le retourner dans le case du VM
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
        }else{
            debugPrint("vous n'êtes pas connecté")
            model.state = .error
        }
    }
}


