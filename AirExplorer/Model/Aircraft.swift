//
//  model.swift
//  AirExplorer
//
//  Created by alumne on 12/01/2026.
//

import Foundation

struct Aircraft: Codable {
    
    let id = UUID()
    let manufacturer: String
    let model: String
    let engineType: String
    let engineThrustLbFt: String?
    let maxSpeedKnots: String?
    let cruiseSpeedKnots: String?
    let ceilingFt: String?
    let takeoffGroundRunFt: String?
    let landingGroundRollFt: String?
    let grossWeightLbs: String?
    let emptyWeightLbs: String?
    let lengthFt: String?
    let heightFt: String?
    let wingSpanFt: String?
    let rangeNauticalMiles: String?
    
}
