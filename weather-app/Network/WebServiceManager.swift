//
//  WebServiceManager.swift
//  weather-app
//
//  Created by Ming Chu on 21/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation
import Alamofire

typealias WebServiceCompletionHandler<T: Codable>  = ((T?, Error?) -> Void)

class WebServiceManager {
    static let shared = WebServiceManager()

    var baseUrlString: String? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else { return nil }
        guard let dictionary = NSDictionary(contentsOfFile: path) else { return nil }
        return dictionary["WeatherAPIEndpoint"] as? String
    }

    var apiKey: String? {
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist") else { return nil }
        guard let dictionary = NSDictionary(contentsOfFile: path) else { return nil }
        return dictionary["WeatherAPIKey"] as? String
    }

    func request<T: Codable>(params: Parameters?,
                             method: HTTPMethod = .get,
                             completion: @escaping WebServiceCompletionHandler<T>) {

        guard let baseUrlString = baseUrlString else { return }
        guard let apiKey = apiKey else { return }

        var params = params ?? Parameters()
        params["appid"] = apiKey

        AF.request(baseUrlString, method: method, parameters: params).responseData { (response) in
            logger.debug("finished request: \(String(describing: response.request))")
            switch response.result {
            case .success(let data):
                do {
                    let responseObj = try JSONDecoder().decode(T.self, from: data)
                    completion(responseObj, nil)
                } catch {
                    if let errorResponse = try? JSONDecoder().decode(WeatherResponseError.self, from: data) {
                        logger.debug(errorResponse)
                        completion(nil, errorResponse)
                    } else {
                        logger.debug(error)
                        completion(nil, error)
                    }
                }
            case .failure(let error):
                logger.debug(error)
                completion(nil, error)
            }
        }
    }
}

