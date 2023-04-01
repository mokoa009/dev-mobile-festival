//
//  ZoneIntent.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//


import Foundation
import SwiftUI


struct ZoneIntent {
    
    @ObservedObject private var model : ZoneListViewModel
    
    init(model: ZoneListViewModel){
        self.model = model
    }
    
    func getZones(idFestival: Int) async {
        self.model.state = .loadingZones
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationFZ/festival/"+String(idFestival)) else {
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

                guard let decoded : [ZoneDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                model.state = .loadedZones(decoded)
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


    func deleteZone(id: Int, token : String?) async {
        self.model.state = .deleteZone
        if(token != nil){
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationFZ/delete") else {
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
                    "idZone":id,
                    "idFestival":self.model.idFestival
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
}


