//
//  JSONHelper.swift
//  mobile-mvi
//
//  Created by garcy on 17/03/2023.
//

import Foundation
/*
extension URLSession{
    //pour décoder le json récupérer de l'api
    func getJSON<T: Decodable>(from url:URL) async throws -> T{
        let (data,_) = try await data(from:url)
        let decoder = JSONDecoder() //décodeur
        let decoded = try decoder.decode(T.self,from: data)
        return decoded
    }
}*/
struct JSONHelper{
    static func decode<T : Decodable>(data: Data) async -> T?{
        let decoder = JSONDecoder()

        do {
            let decoded = try decoder.decode(T.self, from: data)
            return decoded
        } catch {
            return nil
        }
    }
    
    static func encode<T : Encodable>(data: T) async -> Data?{
        let encoder = JSONEncoder()
        return try? encoder.encode(data)
    }
}
