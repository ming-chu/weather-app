//
//  WeatherRouter.swift
//  weather-app
//
//  Created Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class WeatherRouter: WeatherWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = WeatherViewController(nibName: nil, bundle: nil)
        let interactor = WeatherInteractor()
        let router = WeatherRouter()
        let presenter = WeatherPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
