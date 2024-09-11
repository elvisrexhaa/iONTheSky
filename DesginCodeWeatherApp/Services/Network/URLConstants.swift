//
//  URLConstants.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 13/05/2024.
//

import Foundation


struct URLConstants {
    
    let apiKey = "357e5a2d755fdc1e1829e721c908ee87"
    
    static func getWeatherByCity(city: String) -> String {
        return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&appid=\(URLConstants().apiKey)"
    }
    
}
