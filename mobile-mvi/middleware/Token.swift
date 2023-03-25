//
//  token.swift
//  mobile-mvi
//
//  Created by garcy on 25/03/2023.
//

import Foundation
import JWTDecode

struct Token{
    
    static func isConnected() -> Bool {
        return UserDefaults.standard.object(forKey: "token") != nil
    }
    
    static func isAdmin() -> Bool{
        do{
            if(UserDefaults.standard.object(forKey: "token") != nil){
                let jwt = try decode(jwt: String(data: UserDefaults.standard.object(forKey: "token") as! Data, encoding: .utf8)!)

                if let isAdmin = jwt["isAdmin"].integer {
                    return isAdmin == 1
                }else{
                    debugPrint("erreur format token")
                    return false
                }
            }else{
                return false
            }
        }catch{
            debugPrint(error)
            debugPrint("Error decodage Token :\(error) dec")
            return false
        }
    }
    
    static func getIdUtilisateur() -> Int {
        do{
            if(UserDefaults.standard.object(forKey: "token") != nil){
                let jwt = try decode(jwt: String(data: UserDefaults.standard.object(forKey: "token") as! Data, encoding: .utf8)!)

                if let idUtilisateur = jwt["idUtilisateur"].integer {
                    return idUtilisateur
                }else{
                    debugPrint("erreur format token")
                    return -1
                }
            }else{
                return -1
            }
        }catch{
            debugPrint(error)
            debugPrint("Error decodage Token :\(error) dec")
            return -1
        }
    }
    
    static func deconnexion(){
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
    static func getToken() -> String {
        do{
            if(UserDefaults.standard.object(forKey: "token") == nil){
                return ""
            }else{
                let jwt = try decode(jwt: String(data: UserDefaults.standard.object(forKey: "token") as! Data, encoding: .utf8)!)
                return jwt.string
            }
        }catch{
            debugPrint(error)
            debugPrint("Error decodage JWT token")
            return ""
        }
    }
    
    static func memeId(idUtilisateur : Int) -> Bool {
        if(UserDefaults.standard.object(forKey: "token") != nil){
            return idUtilisateur == getIdUtilisateur()
        }else{
            return false
        }
    }
}
                    

