//
//  WheaterAttributes.swift
//  wheater
//
//  Created by Hanif Fadillah Amrynudin on 20/09/22.
//

import SwiftUI
import ActivityKit

struct WheaterAttributes: ActivityAttributes {
    
    struct ContentState: Codable,Hashable {
        
        var conditionId: Int
        var nameCity: String
        var wind: Float
        var temp: Float
        var hum: Int
        var desc: String
        
        var windString: String {
            let data = String(format: "%.f", wind)
            let format = " Km/h"
            
            let result = data + format
            
            return result
        }
        var temperatureString: String {
            let data = String(format: "%.f", temp)
            let format = "°"
            
            let result = data + format
            
            return result
        }
        
        var humidityString: String {
            let data = "\(hum)"
            let format = " %    "
            
            let result = data + format
            
            return result
        }
        
        var conditionName: String {
            switch conditionId {
            case 200...232:
                return "cloud.bolt.fill"
            case 300...321:
                return "cloud.drizzle.fill"
            case 500...531:
                return "cloud.rain.fill"
            case 600...622:
                return "cloud.snow.fill"
            case 701...781:
                return "cloud.fog.fill"
            case 800:
                return "sun.max.fill"
            case 801...804:
                return "cloud.bolt.fill"
            default:
                return "cloud.sun.fill"
            }
        }
    }
}

