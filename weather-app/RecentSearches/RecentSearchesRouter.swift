//
//  RecentSearchesRouter.swift
//  weather-app
//
//  Created Ming Chu on 22/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class RecentSearchesRouter: RecentSearchesWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = RecentSearchesViewController(nibName: nil, bundle: nil)
        let interactor = RecentSearchesInteractor()
        let router = RecentSearchesRouter()
        let presenter = RecentSearchesPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
