//
//  AjoutFestivalIntent.swift
//  mobile-mvi
//
//  Created by etud on 28/03/2023.
//

import Foundation
import SwiftUI

struct AjoutFestivalIntent {
    
    @ObservedObject private var model : AjoutFestivalViewModel
    
    init(model: AjoutFestivalViewModel){
        self.model = model
    }
    
    func ajouterFestival(id: Int) async {
        self.model.state = .addingFestival
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/festivals/close") else {
            debugPrint("bad url getUser")
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "PUT"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requete.addValue("Bearer "+Token.getToken(),forHTTPHeaderField:"Authorization")
            requete.addValue("*/*",forHTTPHeaderField: "Accept")
            
            let body = [
                "id":id
                //rajouter les bons arguments
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
                model.state = .added
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
