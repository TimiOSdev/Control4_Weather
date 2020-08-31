//
//  Root.swift
//  Control4 Weather
//
//  Created by Tim on 8/29/20.
//  Copyright © 2020 Tim. All rights reserved.
//

import Foundation

struct Root: Codable {
    struct Weather: Codable {
        let id : Int
        let icon: String
        let main: String
        let description: String
    }
    
    struct Main: Codable {
        let temp: Float
        let feelsLike: Float
        let tempMin: Float
        let tempMax: Float
    }
    
    var weather: [Weather]
    var main: Main
}



