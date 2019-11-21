//
//  WeatherProtocols.swift
//  weather-app
//
//  Created Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol WeatherWireframeProtocol: class {

}
//MARK: Presenter -
protocol WeatherPresenterProtocol: class {

    var interactor: WeatherInteractorInputProtocol? { get set }

    func requestCurrentWeather(keyword: String)
}

//MARK: Interactor -
protocol WeatherInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func fetchCurrentWeatherDidSuccess(weatherResponse: WeatherResponse)
    func fetchCurrentWeatherDidFailed(error: Error?)
}

protocol WeatherInteractorInputProtocol: class {

    var presenter: WeatherInteractorOutputProtocol?  { get set }

    /* Presenter -> Interactor */
    func fetchCurrentWeather(queryType: QueryType)
}

//MARK: View -
protocol WeatherViewProtocol: class {

    var presenter: WeatherPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func updateCurrentWeather(viewModel: WeatherViewModelProtocol)
    func showError(errorMessage: String)
}
