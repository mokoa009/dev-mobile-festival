//
//  ZoneCreneauBenevoleIntent.swift
//  mobile-mvi
//
//  Created by garcy on 27/03/2023.
//

import Foundation
import SwiftUI


struct ZoneCreneauBenevoleIntent {
    
    @ObservedObject private var model : ZoneCreneauBenevoleListViewModel
    
    init(model: ZoneCreneauBenevoleListViewModel){
        self.model = model
    }
    
    func getBenevoles() async {
        self.model.state = .loadingBenevoles
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationBC/zone/"+String(self.model.idZone)+"/creneau/"+String(self.model.idCreneau)+"/jour/"+String(self.model.idJour)) else {
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
                
                guard let decoded : [ZoneCreneauBenevoleDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                model.state = .loadedBenevoles(decoded)
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


    func deleteZoneCreneauBenevole(idBenevole: Int, token : String?) async {
        self.model.state = .deleteBenevole
        if(token != nil){
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationBC/delete") else {
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
                    "idZone":self.model.idZone,
                    "idCreneau":self.model.idCreneau,
                    "idUtilisateur": idBenevole,
                    "idJour":self.model.idJour
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
    
    func affecterZoneCreneauBenevole(utilisateur : UserViewModel, token : String?) async {
        self.model.state = .affectationBenevole
        
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
                    "idUtilisateur": utilisateur.id,
                    "idZone": self.model.idZone,
                    "idJour": self.model.idJour
                ]
                
                guard let encoded = await JSONHelper.encode(data: body) else {
                    print("pb encodage")
                    return
                }
                requete.httpBody = encoded
                let (_, response) = try await URLSession.shared.data(for: requete)

                let httpresponse = response as! HTTPURLResponse
                if httpresponse.statusCode == 200{
                    model.state = .benevoleAffected(utilisateur)
                    model.state = .ready
                }
                else{
                    debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                }
            }
            catch{
                debugPrint("bad request")
            }
        }else{
            debugPrint("vous n'êtes pas co")
            model.state = .error
        }
    }
    
    func getBenevolesNonAffect() async {
        self.model.state = .loadingBenevolesNonAffect
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationBC/zone-creneau/"+String(self.model.idZone)+"/"+String(self.model.idCreneau)+"/"+String(self.model.idJour)) else {
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
                model.state = .loadedBenevolesNonAffect(decoded)
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
