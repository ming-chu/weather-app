//
//  SearchHistoryManager.swift
//  weather-app
//
//  Created by Ming Chu on 22/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

struct SearchHistory: Codable {
    var searchRecords: [SearchRecord] = []
}

struct SearchRecord: Codable, Equatable {
    let recordId: String
    let searchType: String
    var cityName: String?
    var zipCode: Int?
    var gpsLat: Double?
    var gpsLon: Double?

    init(searchType: String) {
        self.recordId = UUID().uuidString
        self.searchType = searchType
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

/// To mangage the search history
class SearchHistoryManager {
    private static let searchHistoryStoreKey = "SearchHistoryManager.SearchHistoryStoreKey"
    static let shared = SearchHistoryManager()

    private var userDefaults: UserDefaults
    private var searchHistory: SearchHistory
    private let jsonEncoder = JSONEncoder()

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.searchHistory = Self.restoreOrCreate(userDefaults: userDefaults)
    }

    func insertRecord(searchRecord: SearchRecord) {
        self.searchHistory.searchRecords.append(searchRecord)
        self.store()
    }

    func getRecords() -> [SearchRecord] {
        return searchHistory.searchRecords
    }

    func cleanRecords() {
        self.searchHistory.searchRecords.removeAll()
        self.store()
    }

    func removeRecord(record: SearchRecord) {
        self.searchHistory.searchRecords.removeAll(where: { $0 == record })
        self.store()
    }

    /// Save the history to userDefaults
    private func store() {
        do {
            let jsonData = try jsonEncoder.encode(self.searchHistory)
            let jsonString = String(data: jsonData, encoding: .utf8)

            if let jsonString = jsonString {
                self.userDefaults.set(jsonString, forKey: Self.searchHistoryStoreKey)
                self.userDefaults.synchronize()
                logger.debug("jsonString: \(jsonString)")
            }
        } catch {
            logger.error("save data failed")
        }
    }

    /// restore the history from userDefaults, create a new one if failed
    /// - Parameter userDefaults: UserDefaults
    private static func restoreOrCreate(userDefaults: UserDefaults) -> SearchHistory {
        let newSearchHistory = SearchHistory()
        guard let jsonString = userDefaults.string(forKey: SearchHistoryManager.searchHistoryStoreKey) else { return newSearchHistory }
        guard let jsonData = jsonString.data(using: .utf8) else { return newSearchHistory }

        do {
            logger.info("Restore History Data ...")
            return try Foundation.JSONDecoder().decode(SearchHistory.self, from: jsonData)
        } catch {
            logger.error("convert object from json failed: \(error)")
            return newSearchHistory
        }
    }
}
