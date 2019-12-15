//
//  WeatherData.swift
//  MyWeatherApp
//
//  Created by Gopabandhu on 14/12/19.
//  Copyright © 2019 Gopabandhu. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    
    let temp: Double
}

struct Weather: Decodable {
    
    let description: String
    let id: Int
}
