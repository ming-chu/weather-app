//
//  WeatherViewController.swift
//  weather-app
//
//  Created Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WeatherViewController: UIViewController {

	var presenter: WeatherPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension WeatherViewController: WeatherViewProtocol {
    func updateCurrentWeather() {
        //TODO: update UI
    }

    func showError(errorMessage: String) {
        //TODO: show error
    }
}
