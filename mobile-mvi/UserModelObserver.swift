//
//  UserModelObserver.swift
//  mobile-mvi
//
//  Created by garcy on 20/03/2023.
//

import Foundation
protocol UserModelObserver {
    func change(name: String)
}
