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
    
    func getCreneaux(idJour: Int) async {
        
        debugPrint("ID JOUR CRENUA")
        debugPrint(idJour)
        self.model.state = .loadingCreneaux
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationCJ/jour/"+String(idJour)) else {
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
                let sdata = String(data: data, encoding: .utf8)!
                debugPrint("les data json")
                debugPrint(sdata)
                guard let decoded : [CreneauJourDTO] = await JSONHelper.decode(data: data) else{
                    debugPrint("mauvaise récup données")
                    self.model.state = .error
                    return
                }
                debugPrint("HO LA LA RECUP DE DONNEE")
                debugPrint(decoded)
                model.state = .loadedCreneaux(decoded)
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
