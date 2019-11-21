//
//  WeatherViewModel.swift
//  weather-app
//
//  Created by Ming Chu on 21/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

protocol WeatherViewModelProtocol {
    var cityName: String { get }
    var weatherDescription: String { get }
    var weatherIconUrl: URL? { get }
    var temperature: String { get }
    var windSpeed: String { get }
    var humidity: String { get }
    var pressure: String { get }
}

class WeatherViewModel: WeatherViewModelProtocol {

    private let weatherResponse: WeatherResponse

    var cityName: String {
        return weatherResponse.name ?? "N/A"
    }

    var weatherDescription: String {
        return weatherResponse.weather?.first?.weatherDescription ?? "N/A"
    }

    var weatherIconUrl: URL? {
        guard let iconName = weatherResponse.weather?.first?.icon else { return nil }
        let urlString = "http://openweathermap.org/img/wn/\(iconName)@2x.png"
        return URL(string: urlString)
    }

    var temperature: String {
        guard let temperatureInKelvin = weatherResponse.main?.temp else { return "N/A"}
        let temperatureInCelsius = temperatureInKelvin - 272.15
        return "\(String(format: "%.0f", temperatureInCelsius))℃"
    }

    var windSpeed: String {
        guard let speed = weatherResponse.wind?.speed else { return "N/A" }
        return "\(speed) m/s"
    }

    var humidity: String {
        guard let humidity = weatherResponse.main?.humidity else { return "N/A" }
        return "\(humidity)%"
    }

    var pressure: String {
        guard let pressure = weatherResponse.main?.pressure else { return "N/A" }
        return "\(pressure) hPa"
    }

    init(weatherResponse: WeatherResponse) {
        self.weatherResponse = weatherResponse
    }
}
