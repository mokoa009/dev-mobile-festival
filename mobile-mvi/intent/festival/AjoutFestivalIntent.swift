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
    
    func ajouterFestival(nom : String, dateDebut : Date, dateFin : Date) async {
        self.model.state = .addingFestival
        
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/festivals/create") else {
            debugPrint("bad url getUser")
            return
        }
        do{
            var requete = URLRequest(url: url)
            requete.httpMethod = "POST"
            //append a value to a field
            requete.addValue("application/json", forHTTPHeaderField: "Content-Type")
            requete.addValue("Bearer "+Token.getToken(),forHTTPHeaderField:"Authorization")
            requete.addValue("*/*",forHTTPHeaderField: "Accept")
            
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            let year = yearFormatter.string(from : dateDebut)
            
            let differenceInSeconds = dateFin.timeIntervalSince(dateDebut)
            let nbJours = differenceInSeconds/(3600*24)
            
            let body : FestivalDTO
            body = FestivalDTO(idFestival: -1, nom: nom, annee: (year as NSString).integerValue, nbJours: Int(nbJours), cloture: -1)
            
            print(body)
            
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
