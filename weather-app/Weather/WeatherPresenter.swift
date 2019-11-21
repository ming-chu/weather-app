//
//  WeatherPresenter.swift
//  weather-app
//
//  Created Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WeatherPresenter: WeatherPresenterProtocol {

    weak private var view: WeatherViewProtocol?
    var interactor: WeatherInteractorInputProtocol?
    private let router: WeatherWireframeProtocol

    init(interface: WeatherViewProtocol, interactor: WeatherInteractorInputProtocol?, router: WeatherWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func requestCurrentWeather(keyword: String) {
        let queryType: QueryType = keyword.containsNumbersOnly ? QueryType.zipCode(code: Int(keyword) ?? 0) : .cityName(name: keyword)
        interactor?.fetchCurrentWeather(queryType: queryType)
    }
}

extension WeatherPresenter: WeatherInteractorOutputProtocol {
    func fetchCurrentWeatherDidSuccess(weatherResponse: WeatherResponse) {
        let viewModel = WeatherViewModel(weatherResponse: weatherResponse)
        view?.updateCurrentWeather(viewModel: viewModel)
    }

    func fetchCurrentWeatherDidFailed(error: Error?) {
        guard let errorMessage = error?.localizedDescription else { return }
        view?.showError(errorMessage: errorMessage)
    }
}


