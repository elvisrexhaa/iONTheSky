//
//  WeatherViewModel.swift
//  DesginCodeWeatherApp
//
//  Created by Elvis Rexha on 14/05/2024.
//

import Foundation
import SwiftUI


class WeatherViewModel: ObservableObject {
    
    @Published var weather: Weather? {
        didSet { storeWeatherUserDefaults() }
    }
    @Published var city: String = ""
    @Published var weathers: [Weather] = []
    
    init() {
        getWeatherFromUserDefaults()
    }
    
    
    func getWeather() {
        
        Task { @MainActor in
            self.weather = try await NetworkService.shared.getWeather(url: URLConstants.getWeatherByCity(city: city))
            addWeatherToList()
            storeWeatherUserDefaults()
        }
        
    }
    
    func getWeatherFromUserDefaults() {
        do {
            if let cachedWeatherData = UserDefaults.standard.data(forKey: "stored_weathers") {
                let decodedWeathers = try JSONDecoder().decode([Weather].self, from: cachedWeatherData)
                self.weathers = decodedWeathers
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    func storeWeatherUserDefaults() {
        do {
            let encodedWeathers = try JSONEncoder().encode(weathers)
            UserDefaults.standard.set(encodedWeathers, forKey: "stored_weathers")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addWeatherToList() {
        withAnimation(.bouncy) {
            if let weather = weather {
                weathers.insert(weather, at: 0)
            }
        }
  
    }
    
    func deleteItem(weather: Weather) {
        if let index = weathers.firstIndex(where: { $0.id == weather.id }) {
            weathers.remove(at: index)
        }
    }
 
}
