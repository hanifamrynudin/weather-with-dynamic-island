//
//  WeatherData.swift
//  wheater
//
//  Created by Hanif Fadillah Amrynudin on 01/09/22.
//

import Foundation


struct WeatherData: Decodable {
    
    let name: String
    
}

struct Wind: Decodable {
    let speed: Float
}

struct Main: Decodable {
    let temp: Double
    let humidity: Int
}

struct Weather: Decodable {
    let main: String
    let id: Int
}
