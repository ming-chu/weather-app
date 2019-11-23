//
//  SearchHistoryManager.swift
//  weather-app
//
//  Created by Ming Chu on 22/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

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

    func getAllRecords() -> [SearchRecord] {
        return searchHistory.searchRecords
    }

    func getRecord(recordId: String) -> SearchRecord? {
        return searchHistory.searchRecords.filter({ $0.recordId == recordId }).first
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
