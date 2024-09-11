// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let coord: Coord
    let weather: [WeatherElement]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys: Sys
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}


extension Weather {
    static func weatherImageByTemp(temp: Double) -> String {
        if temp < 5 {
            return "thunder"
        } else if temp < 15 {
            return "sun&rain"
        } else if temp < 25 {
            return "sun&cloud2"
        } else if temp < 30 {
            return "sun&cloud&rain"
        } else if temp < 35 {
            return "sun&cloud"
        } else if temp < 40 {
            return "sun"
        } else if temp < 45 {
            return "rain"
        } else if temp < 50 {
            return "quatersun"
        } else if temp < 55 {
            return "quatermoon"
        } else if temp < 60 {
            return "moon&clouds"
        } else if temp < 65 {
            return "moon&cloud&stars"
        } else if temp < 70 {
            return "quatersun&cloud"
        } else if temp < 75 {
            return "fullmoon"
        } else {
            return "halfmoon"
        }
    }
}






