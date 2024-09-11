//
//  NetworkService.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 13/05/2024.
//

import Foundation

protocol WeatherAPIProtocol {
    func getWeather(url: String) async throws -> Weather
}


class NetworkService: WeatherAPIProtocol {
    
    static let shared = NetworkService()
    
    func getWeather(url: String) async throws -> Weather {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let weather = try JSONDecoder().decode(Weather.self, from: data)
            return weather
        } catch {
            print(error.localizedDescription)
            throw URLError(.badServerResponse)
        }
        
    }
    
    
    
}
