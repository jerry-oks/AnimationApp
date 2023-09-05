//
//  DataStore.swift
//  AnimationApp
//
//  Created by HOLY NADRUGANTIX on 05.09.2023.
//

import Foundation
import SpringAnimation

final class DataStore {
    static var shared = DataStore()
    
    let presets = AnimationPreset.allCases.map { $0.rawValue }
    let curves = AnimationCurve.allCases.map { $0.rawValue }
    
    private init() {}
}
