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
import CoreLocation

class WeatherPresenter: WeatherPresenterProtocol {

    weak private var view: WeatherViewProtocol?
    var interactor: WeatherInteractorInputProtocol?
    private let router: WeatherWireframeProtocol

    init(interface: WeatherViewProtocol, interactor: WeatherInteractorInputProtocol?, router: WeatherWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }

    func requestWeatherSearch(keyword: String) {
        let queryType: QueryType = keyword.containsNumbersOnly ? QueryType.zipCode(code: Int(keyword) ?? 0) : .cityName(name: keyword)
        interactor?.fetchCurrentWeather(queryType: queryType)
    }

    func requestGPSWeatherSearch() {
        guard let currentLocation = self.interactor?.latestLocation else { return }
        let queryType = QueryType.coordinates(lat: currentLocation.coordinate.latitude, lon: currentLocation.coordinate.longitude)
        interactor?.fetchCurrentWeather(queryType: queryType)
    }

    func requestWeatherForMostRecentSearch() {
        guard let lastQueryType = SearchHistoryManager.shared.getRecords().last?.queryType else {
            if self.interactor?.latestLocation != nil {
                requestGPSWeatherSearch()
            } else {
                requestWeatherSearch(keyword: "Hong Kong")
            }
            return
        }
        interactor?.fetchCurrentWeather(queryType: lastQueryType)
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


