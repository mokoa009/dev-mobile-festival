//
//  CreneauIntent.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct CreneauFormIntent {
    
    @ObservedObject private var model : CreneauFormViewModel
    
    init(model: CreneauFormViewModel){
        self.model = model
    }
    
    func createCreneauJour(idJour : Int, token: String?) async {
        self.model.state = .demandeCreation
        if(token != nil){
            guard let url = URL(string:"https://dev-festival-api.cluster-ig4.igpolytech.fr/creneaux/create") else {
                debugPrint("bad url getUser")
                return
            }
            do{
                var requete = URLRequest(url: url)
                requete.httpMethod = "POST"
                //append a value to a field
                requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let body = CreneauDTO(idCreneau: -1, heureDebut: self.model.heureDebut, heureFin: self.model.heureFin)
                
                guard let encoded = await JSONHelper.encode(data: body) else {
                    print("pb encodage")
                    return
                }
                requete.httpBody = encoded
                let (_, response) = try await URLSession.shared.data(for: requete)
                let httpresponse = response as! HTTPURLResponse
                if httpresponse.statusCode == 200{
                    model.state = .creneauCreated
                    //recupération idCreneau crée
                    await getIdCreneau(heureDebut: self.model.heureDebut, heureFin: self.model.heureFin,token: token!)
                    //affectation creaneau au jour
                    await affecterCreneauJour(idJour: idJour, token: token!)
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
            debugPrint("Vous n'êtes pas co")
            model.state = .error
        }
    }
    
    
    func affecterCreneauJour(idJour: Int, token: String?) async {
        self.model.state = .affectationCreneau
        if(token != nil){
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationCJ/create") else {
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
                    "idJour": idJour
                ]
                
                guard let encoded = await JSONHelper.encode(data: body) else {
                    print("pb encodage")
                    return
                }
                requete.httpBody = encoded
                let (_, response) = try await URLSession.shared.data(for: requete)

                let httpresponse = response as! HTTPURLResponse
                if httpresponse.statusCode == 200{
                    model.state = .creneauAffected
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
            debugPrint("vous n'êtes pas connecté")
            model.state = .error
        }
    }
    
    func getIdCreneau(heureDebut: String, heureFin: String,token: String?) async {
        self.model.state = .getIdCreneau
        
        if(token != nil){
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/creneaux/getIdCreneauByHeure") else {
                debugPrint("bad url getUser")
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
                    "heureDebut":heureDebut,
                    "heureFin":heureFin
                ]
                guard let encoded = await JSONHelper.encode(data: body) else {
                    print("pb encodage")
                    self.model.state = .error
                    return
                }
                requete.httpBody = encoded
                let (data, response) = try await URLSession.shared.data(for: requete)
                let httpresponse = response as! HTTPURLResponse
                if httpresponse.statusCode == 200{
                    guard let decoded : [IdCreneauDTO] = await JSONHelper.decode(data: data) else{
                        debugPrint("mauvaise récup données")
                        self.model.state = .error
                        return
                    }
                    model.state = .idCreneauRecu(decoded[0].idCreneau)
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

