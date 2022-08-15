//
//  WeatherData.swift
//  Clima
//
//  Created by Jittanan Jackthreemongkol on 15/8/2565 BE.
//  Copyright © 2565 BE App Brewery. All rights reserved.
//

import Foundation

struct WeatherData :Codable {
    let name :String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
    
}
