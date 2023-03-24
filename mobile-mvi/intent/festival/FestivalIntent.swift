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
        
        self.model.state = .loadedFestivals([])
                guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/festivals") else {
                    debugPrint("bad url getFestival")
                    return
                }
                do{
                    /*var requete = URLRequest(url: url)
                    requete.httpMethod = "GET"
                    //append a value to a field
                    requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
                     */
                    //set (replace) a value to a field
                    //requete.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
                    /*
                    guard let encoded = await JSONHelper.encode(data: self.Festival) else {
                        print("pb encodage")
                        return
                    }
                    let (data, response) = try await URLSession.shared.upload(for: requete, from: encoded)*/
                    let (data, response) = try await URLSession.shared.data(from: url)
                    debugPrint("data normal")
                    debugPrint(data)
                    let sdata = String(data: data, encoding: .utf8)!
                    let httpresponse = response as! HTTPURLResponse
                    if httpresponse.statusCode == 200{
                       // model.state = .loadedFestivals([FestivalDTO(idUtilisateur: 11, nom: "truc", prenom: "mgd", email: "ege", mdp: "fefe", isAdmin: 1)])
                        
                        debugPrint("\(sdata)")
                        guard let decoded : [FestivalDTO] = await JSONHelper.decode(data: data) else{
                            debugPrint("mauvaise récup données")
                            return
                        }
        
                        debugPrint("donneees decodeess")
                        debugPrint(decoded)
                        model.state = .loadedFestivals(decoded)
        
                    }
                    else{
                        debugPrint("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
                    }
                }
                catch{
                    debugPrint("bad request")
                }
    }
}


