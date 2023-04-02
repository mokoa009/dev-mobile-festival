//
//  FestivalZoneIntent.swift
//  mobile-mvi
//
//  Created by garcy on 26/03/2023.
//


import Foundation
import SwiftUI


struct FestivalZoneIntent {
    
    @ObservedObject private var model : FestivalListZoneViewModel
    
    init(model: FestivalListZoneViewModel){
        self.model = model
    }
    
    func getZones(id: Int) async {
        self.model.state = .loadingZones
        guard let url = URL(string: "https://dev-festival-api.cluster-ig4.igpolytech.fr/affectationJZ/jour/"+String(id)) else {
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
                guard let decoded : [ZoneAffectationDTO] = await JSONHelper.decode(data: data) else{
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
}
