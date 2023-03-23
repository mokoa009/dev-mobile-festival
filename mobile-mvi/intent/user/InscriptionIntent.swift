//
//  InscriptionIntent.swift
//  mobile-mvi
//
//  Created by garcy on 22/03/2023.
//

import Foundation
import SwiftUI

struct InscriptionIntent {
    
    @ObservedObject private var model : InscriptionViewModel
    
    init(model: InscriptionViewModel){
        self.model = model
    }
    
    func inscription() async {
        self.model.state = .demandeInscription
        
        guard let url = URL(string:"https://awi-festival-api.cluster-ig4.igpolytech.fr/utilisateurs/create") else {
            debugPrint("bad url getUser")
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "POST"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body = UserDTO(idUtilisateur: -1, nom: model.nom, prenom: model.prenom, email: model.email, mdp: model.mdp, isAdmin: model.isAdmin)
            
            guard let encoded = await JSONHelper.encode(data: body) else {
                print("pb encodage")
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
                model.state = .inscription
                model.state = .ready
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
