//
//  TrackIntent.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation
import SwiftUI



struct TrackIntent {
    /*
    @ObservedObject private var model : TrackViewModel
    
    init(track: TrackViewModel){
        self.model = track
    }*/
    
    
    // intent to change name of ViewModel
    func change(name: String, of model :TrackViewModel){
        let newname = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if newname.count < 4{
           // self.model.state = .error(.tooShortName(newname))
        } else {
            model.state = .changingName(name)
        }
        
        // les observateurs ont été prévenus du résultat .ready
        model.state = .ready
    }
    func getUsers(of model :TrackViewModel) async {
        model.state = .loadingUsers
        
        guard let url = URL(string: "https://awi-festival-api.cluster-ig4.igpolytech.fr/utilisateurs") else {
            print("bad url getUser")
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
            guard let encoded = await JSONHelper.encode(data: self.user) else {
                print("pb encodage")
                return
            }
            let (data, response) = try await URLSession.shared.upload(for: requete, from: encoded)*/
            let (data, response) = try await URLSession.shared.data(from: url)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                print("result: \(sdata)")
                guard let decoded : ResponseUser = await JSONHelper.decode(data: data) else{
                    print("mauvaise récup données")
                    return
                }
                print("donneees decodeess")
                print(decoded.data)
            }
            else{
                print("error \(httpresponse.statusCode):\(HTTPURLResponse.localizedString(forStatusCode: httpresponse.statusCode))")
            }
        }
        catch{
            print("bad request")
        }
    }}
/*
struct SomeTrackIntent {
    
    // intent to change name of ViewModel
    func change(name: String, of model : TrackViewModel){
        let newname = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if newname.count < 4{
            model.state = .error
           // model.state = .error(.tooShortName(newname))
        } else {
            model.state = .changingName(name)
        }
   
    }
}*/

