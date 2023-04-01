//
//  mobile_mviApp.swift
//  mobile-mvi
//
//  Created by garcy on 14/02/2023.
//

import SwiftUI

@main
struct mobile_mviApp: App {
    @StateObject var tokenManager = Token()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(tokenManager)
        }
    }
}
