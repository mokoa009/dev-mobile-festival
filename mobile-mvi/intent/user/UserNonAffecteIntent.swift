//
//  UserNonAffecteIntent.swift
//  mobile-mvi
//
//  Created by garcy on 29/03/2023.
//
import Foundation
import SwiftUI

struct UserNonAffecteIntent {
    
    @ObservedObject private var model : UserNonAffecteListViewModel
    
    init(model: UserNonAffecteListViewModel){
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
    
    func affecterZoneCreneauBenevole(utilisateurSelect : UserViewModel, token : String?) async {
        self.model.state = .affectingBenevole
        if(token != nil){
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationBC/create") else {
                debugPrint("bad url getUser")
                self.model.state = .error
                return
            }
            do{
                var requete = URLRequest(url: url)
                requete.httpMethod = "POST"
                //append a value to a field
                requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
                requete.addValue("Bearer "+token!,forHTTPHeaderField:"Authorization")
                requete.addValue("*/*",forHTTPHeaderField: "Accept")
                
                let body = [
                    "idCreneau" : self.model.idCreneau,
                    "idUtilisateur": utilisateurSelect.id,
                    "idZone": self.model.idZone
                ]
                
                guard let encoded = await JSONHelper.encode(data: body) else {
                    print("pb encodage")
                    return
                }
                requete.httpBody = encoded
                let (_, response) = try await URLSession.shared.data(for: requete)

                let httpresponse = response as! HTTPURLResponse
                if httpresponse.statusCode == 200{
                    model.state = .benevoleAffected(utilisateurSelect)
                    model.state = .ready
                    debugPrint("affected benevole")
                }
                else{
                    debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                }
            }
            catch{
                debugPrint("bad request")
            }
        }else{
            debugPrint("vous n'êtes pas connecté")
            model.state = .error
        }
    }
}
