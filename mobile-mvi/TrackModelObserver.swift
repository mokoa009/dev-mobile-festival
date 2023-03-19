//
//  TrackModelObserver.swift
//  mobile-mvi
//
//  Created by Oce on 14/02/2023.
//

import Foundation

protocol TrackModelObserver {
    func change(name: String)
}
