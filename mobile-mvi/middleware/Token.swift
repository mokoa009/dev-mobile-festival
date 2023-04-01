//
//  token.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation
import JWTDecode

class Token: ObservableObject{
    
    @Published var token : JWT? {
        didSet{
            if(token != nil){
                if let data = token!.string.data(using: .utf8){
                    UserDefaults.standard.set(data, forKey: "token")
                }
            }
        }
    }

    init(){
        if(UserDefaults.standard.object(forKey: "token") != nil){
            do{
                self.token = try decode(jwt: String(data:UserDefaults.standard.object(forKey: "token") as! Data, encoding: .utf8)!)
            }catch{
                debugPrint(error)
                debugPrint("error decodage JWT token")
            }
        }
    }
    
    func isAdmin() -> Bool{
        if(self.token != nil){
            if let isAdmin = self.token!["isAdmin"].integer {
                return isAdmin == 1
            }else{
                debugPrint("erreur format token")
                return false
            }
        }else{
            return false
        }
    }
    
    func getIdUtilisateur() -> Int {
        if(self.token != nil){
            if let idUtilisateur = self.token!["idUtilisateur"].integer {
                return idUtilisateur
            }else{
                debugPrint("erreur format token")
                return -1
            }
        }else{
            return -1
        }
    }
    
    func deconnexion(){
        self.token = nil
    }
    
    func memeId(idUtilisateur : Int) -> Bool {
        if(self.token != nil){
            return self.token!["idUtilisateur"].integer == getIdUtilisateur()
        }else{
            return false
        }
    }
}
                    

