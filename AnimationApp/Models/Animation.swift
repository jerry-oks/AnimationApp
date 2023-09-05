//
//  Animation.swift
//  AnimationApp
//
//  Created by HOLY NADRUGANTIX on 05.09.2023.
//

import Foundation

struct Animation {
    let preset: String
    let curve: String
    let force: Double
    let delay: Double
    let duration: Double
    
    func getRandom() -> Animation {
        Animation(
            preset: DataStore.shared.presets.randomElement() ?? "pop",
            curve: DataStore.shared.curves.randomElement() ?? "linear",
            force: Double.random(in: 0.2...4),
            delay: Double.random(in: 0.2...2),
            duration: Double.random(in: 0.2...2)
        )
    }
}
