//
//  SearchHistory.swift
//  weather-app
//
//  Created by Ming Chu on 23/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

struct SearchHistory: Codable {
    var searchRecords: [SearchRecord] = []
}

struct SearchRecord: Codable, Equatable {
    let recordId: String
    let searchType: String
    let timestamp: Double
    var cityName: String?
    var zipCode: Int?
    var gpsLat: Double?
    var gpsLon: Double?

    init(searchType: String, timestamp: Double = Date().timeIntervalSince1970) {
        self.recordId = UUID().uuidString
        self.searchType = searchType
        self.timestamp = timestamp
    }

    var queryType: QueryType? {
        guard let typeName = QueryTypeName(rawValue: searchType) else { return nil }
        switch typeName {
        case .cityName:
            guard let cityName = self.cityName else { return nil }
            return QueryType.cityName(name: cityName)
        case .zipCode:
            guard let zipCode = self.zipCode else { return nil }
            return QueryType.zipCode(code: zipCode)
        case .coordinates:
            guard let lat = self.gpsLat, let lon = self.gpsLon else { return nil }
            return QueryType.coordinates(lat: lat, lon: lon)
        }
    }

    static func == (lhs: SearchRecord, rhs: SearchRecord) -> Bool {
        return lhs.recordId == rhs.recordId
    }
}
