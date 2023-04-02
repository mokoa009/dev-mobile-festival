//
//  FestivalCreneauIntent.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//

import Foundation
import SwiftUI

struct FestivalCreneauIntent {
    
    @ObservedObject private var model : FestivalListCreneauViewModel
    
    init(model: FestivalListCreneauViewModel){
        self.model = model
    }
    
    func getCreneauxZones(idJour: Int) async {
        
        //get zones by idJour
        self.model.state = .loadingZones
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationJZ/jour/"+String(idJour)) else {
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
                guard let decoded : [ZoneAffectationDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                //let sdata = String(data :data, encoding: .utf8)!

                //get creneau by idZone
                var tabCreneauZone : [CreneauZoneDTO?] = []
                for zone in decoded {
                    let creneaux = await getCreneaux(idZone:zone.zone.id)
                    if(creneaux == []){
                        tabCreneauZone.append(CreneauZoneDTO(zone: Zone(id: zone.zone.id, nom: zone.zone.nom, nbBenevoles: zone.zone.nbBenevoles), creneau: Creneau(id: -1, heureDebut: "", heureFin: "")))
                    }else{
                        tabCreneauZone.append(contentsOf:creneaux)
                    }
                }
                self.model.state = .loadedCreneaux(tabCreneauZone)
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
    func getCreneaux(idZone: Int) async -> [CreneauZoneDTO?] {
        
        //get zones by idJour
        self.model.state = .loadingCreneaux
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationZC/zone/"+String(idZone)) else {
            debugPrint("bad url getUser")
            self.model.state = .error
            return []
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "GET"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let (data, response) = try await URLSession.shared.data(for: requete)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                guard let decoded : [CreneauZoneDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return []
                }
               return decoded
                
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
        return []
    }
    
    func supprimerCreneau(creneau : Creneau,idZone: Int,idJour: Int, token: String?) async {
        self.model.state = .deletingCreneau
        if(token != nil){
            //suppression creneau de la zone
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationZC/delete") else {
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
                    "idCreneau" : creneau.id,
                    "idZone" : idZone,
                    
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
                    model.state = .deletedCreneau(creneau,idZone)
                    // remove tous les benevoles sur le créneau
                    await supprimerAllBenevole(idCreneau: creneau.id,idZone: idZone,idJour:idJour, token:token)
                    
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
    
    func supprimerAllBenevole(idCreneau : Int,idZone: Int, idJour: Int, token: String?) async {
        self.model.state = .deletingCreneauBenevole
        if(token != nil){
            //suppression affectation benevole-creneau
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationBC/creneau/delete") else {
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
                    "idCreneau" : idCreneau,
                    "idZone" : idZone,
                    "idJour" : idJour
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
                    model.state = .deletedCreneauBenevole
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
