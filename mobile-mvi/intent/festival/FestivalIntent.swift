//
//  FestivalIntent.swift
//  mobile-mvi
//
//  Created by Oce on 22/03/2023.
//

import Foundation
import SwiftUI



struct FestivalIntent {
    
    
    @ObservedObject private var model : FestivalListViewModel
    
    init(model: FestivalListViewModel){
        self.model = model
    }
    
   // @ObservedObject private var state : FestivalListViewModel
    
    func getFestivals() async {
        self.model.state = .loadingFestivals
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/festivals") else {
            debugPrint("bad url getFestival")
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "GET"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
             

            let (data, response) = try await URLSession.shared.data(from: url)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                
                guard let decoded : [FestivalDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                model.state = .loadedFestivals(decoded)

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
    
    func deleteFestival(id: Int,token : String?) async {
        if(token != nil){
            for festival in model.festivals {
                if id == festival.id {
                    self.model.state = .deletingFestival(FestivalDTO(festival: festival))
                    break
                }
            }
            
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/festivals/delete") else {
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
                    "id":id
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
            debugPrint("Vous n'êtes pas co")
            model.state = .error
        }
    }
    
    func clotureFestival(id: Int, token: String?) async {
        if(token != nil){
            for festival in model.festivals {
                if id == festival.id {
                    self.model.state = .cloturingFestival(FestivalDTO(festival: festival))
                    break
                }
            }
            
            guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/festivals/close") else {
                debugPrint("bad url getUser")
                return
            }
            do{
                var requete = URLRequest(url: url)
                requete.httpMethod = "PUT"
                //append a value to a field
                requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
                requete.addValue("Bearer "+token!,forHTTPHeaderField:"Authorization")
                requete.addValue("*/*",forHTTPHeaderField: "Accept")
                
                let body = [
                    "id":id
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
                    model.state = .clotured
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
            debugPrint("Vous n'êtes pas co")
            model.state = .error
        }
    }
}



