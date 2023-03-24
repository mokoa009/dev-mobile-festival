//
//  ConnexionIntent.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import Foundation
import SwiftUI

struct ConnexionIntent {
    
    @ObservedObject private var model : ConnexionViewModel
    
    init(model: ConnexionViewModel){
        self.model = model
    }
    
    func connexion() async {
        self.model.state = .authentification
        
        guard let url = URL(string:"https://awi-festival-api.cluster-ig4.igpolytech.fr/utilisateurs/connexion") else {
            debugPrint("bad url getUser")
            self.model.state = .error
            return
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
                return
            }
            requete.httpBody = encoded
            let (data, response) = try await URLSession.shared.data(for: requete)
            debugPrint("data normal")
            debugPrint(data)
            let sdata = String(data: data, encoding: .utf8)!
            let httpresponse = response as! HTTPURLResponse
            if httpresponse.statusCode == 200{
                debugPrint("\(sdata)")
                model.state = .authentified
                //mettre le token quelque part
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
    }
}
