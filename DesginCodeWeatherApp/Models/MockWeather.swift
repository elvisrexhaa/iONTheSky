//
//  Weather.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 11/05/2024.
//

import Foundation

struct MockWeather: Identifiable, Codable, Hashable {
    var id: UUID = .init()
    var city: String
    var mainTemp: Double
    var highTemp: Double
    var lowTemp: Double
//    var weatherImage: String
    
}


extension MockWeather {
    static func mockWeatherData() -> [MockWeather] {
        
        return [
            MockWeather(
                city: "London, United Kingdom",
                mainTemp: 20,
                highTemp: 25,
                lowTemp: 16
            ),
            MockWeather(
                city: "Dubai, United Arab Emirates",
                mainTemp: 30,
                highTemp: 36,
                lowTemp: 26
            ),
            MockWeather(
                city: "Tokyo, Japan",
                mainTemp: -2,
                highTemp: 6,
                lowTemp: -6
            ),
            MockWeather(
                city: "Tirana, Albania",
                mainTemp: 24,
                highTemp: 31,
                lowTemp: 23
            )
        ]
        
        
    }
    
    
    static func weatherImageByTemp(temp: Double) -> String {
        if temp <= 30 && temp > 20{
            return "SunCloudMidRain"
        } else {
            return "Tornado"
        }
        
    }
}




