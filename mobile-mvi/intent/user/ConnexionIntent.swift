//
//  ConnexionIntent.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import Foundation
import SwiftUI
import JWTDecode

struct ConnexionIntent {
    
    @ObservedObject private var model : ConnexionViewModel
    
    init(model: ConnexionViewModel){
        self.model = model
    }
    
    func connexion() async -> JWT?{
        self.model.state = .authentification
        
        guard let url = URL(string:"https://dev-festival-api.cluster-ig4.igpolytech.fr/utilisateurs/connexion") else {
            debugPrint("bad url getUser")
            self.model.state = .error
            return nil
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "POST"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body = [
                "email":model.email,
                "mdp":model.mdp
            ]
            guard let encoded = await JSONHelper.encode(data: body) else {
                print("pb encodage")
                self.model.state = .error
                return nil
            }
            requete.httpBody = encoded
            let (data, response) = try await URLSession.shared.data(for: requete)
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                model.state = .authentified
                model.state = .ready
                let jwt = try decode(jwt: String(data:data, encoding: .utf8)!)
                debugPrint("decode data to jwt")
                debugPrint(jwt)
                return jwt
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
        return nil
    }
}
