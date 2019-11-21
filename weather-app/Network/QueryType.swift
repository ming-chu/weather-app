//
//  QueryType.swift
//  weather-app
//
//  Created by Ming Chu on 21/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

enum QueryType {
    /**
    get weather by ZIP code

    Examples of API calls:
    ```
    api.openweathermap.org/data/2.5/weather?q=London
    ```
     */
    case cityName(name: String)

    /**
    get weather by ZIP code

    Examples of API calls:
    ```
    api.openweathermap.org/data/2.5/weather?zip=94040
    ```
     */
    case zipCode(code: Int)

    /**
    get weather by geographic coordinates

    Examples of API calls:
    ```
    api.openweathermap.org/data/2.5/weather?lat=35&lon=139
    ```
     */
    case coordinates(lat: Double, lon: Double)

    var params: [String : Any] {
        switch self {
        case .cityName(let name):
            return ["q" : name]
        case .zipCode(let zipCode):
            return ["zip" : zipCode]
        case .coordinates(let lat, let lon):
            return ["lat" : lat, "lon" : lon]
        }
    }
}
