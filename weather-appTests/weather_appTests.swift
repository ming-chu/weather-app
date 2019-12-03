//
//  weather_appTests.swift
//  weather-appTests
//
//  Created by Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import XCTest
@testable import weather_app

class weather_appTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testInsertSearchRecord() {
        let testingSearchType = QueryTypeName.cityName.rawValue + UUID().uuidString
        let testingCityName = "London" + UUID().uuidString

        let manager = SearchHistoryManager(userDefaults: MockUserDefaults())
        var record = SearchRecord(searchType: testingSearchType)
        record.cityName = testingCityName

        manager.insertRecord(searchRecord: record)

        XCTAssertEqual(manager.getRecord(recordId: record.recordId)?.searchType, testingSearchType)
        XCTAssertEqual(manager.getRecord(recordId: record.recordId)?.cityName, testingCityName)
    }

    func testRemoveSearchRecord() {
        let manager = SearchHistoryManager(userDefaults: MockUserDefaults())
        manager.cleanRecords()

        var recordsDict: [String : SearchRecord] = [:]

        for i in (1...100) {
            let testingSearchType = QueryTypeName.cityName.rawValue + UUID().uuidString
            let testingCityName = "London" + UUID().uuidString
            var record = SearchRecord(searchType: testingSearchType)
            record.cityName = testingCityName

            recordsDict[record.recordId] = record

            manager.insertRecord(searchRecord: record)

            XCTAssert(manager.getAllRecords().count == i, "Records count not correct.")
        }

        let totalRecordsCount = recordsDict.keys.count
        for (i, recordId) in recordsDict.keys.enumerated() {
            let record = manager.getRecord(recordId: recordId)
            XCTAssert(record != nil, "Record here should exist!")
            if let record = record {
                manager.removeRecord(record: record)
            }

            let expectRecordsCount = totalRecordsCount - (i + 1)
            XCTAssert(manager.getAllRecords().count == expectRecordsCount, "Records count not correct.")
        }
    }

    func testRecentSearchesInteractorRemoveAllSearchRecord() {
        let recordsCount = Int.random(in: 1...1000)
        print("recordsCount = \(recordsCount)")
        
        let searchHistoryManager = createSearchHistoryManagerWithRecords(recordsCount: recordsCount)
        print("searchHistoryManager.getAllRecords().count = \(searchHistoryManager.getAllRecords().count)")

        let interactor = RecentSearchesInteractor(searchHistoryManager: searchHistoryManager)

        // expected records count is the same even get it from interactor
        XCTAssert(searchHistoryManager.getAllRecords().count == recordsCount, "expected one record only here.")

        // expected no records after remove all search record via interactor.
        interactor.removeAllSearchRecord()
        XCTAssert(searchHistoryManager.getAllRecords().count == 0, "expected no records here.")
    }

    func testRecentSearchesPresenter() {
        let recordsCount = Int.random(in: 1...1000)
        print("recordsCount = \(recordsCount)")

        let searchHistoryManager = createSearchHistoryManagerWithRecords(recordsCount: recordsCount)
        print("searchHistoryManager.getAllRecords().count = \(searchHistoryManager.getAllRecords().count)")

        let interactor = RecentSearchesInteractor(searchHistoryManager: searchHistoryManager)
        let view = RecentSearchesViewController(nibName: nil, bundle: nil)
        let router = RecentSearchesRouter()
        let presenter = RecentSearchesPresenter(interface: view, interactor: interactor, router: router)
        presenter.requestFetchSearchHistory()

        // expected the request will be completed in 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssert(presenter.searchRecords.count == recordsCount, "the records count should be the same.")
        }
    }

    private func createSearchHistoryManagerWithRecords(recordsCount: Int = 10) -> SearchHistoryManager {
        let searchHistoryManager = SearchHistoryManager(userDefaults: MockUserDefaults())

        for _ in 0 ..< recordsCount {
            let testingSearchType = QueryTypeName.cityName.rawValue + UUID().uuidString
            let testingCityName = "London" + UUID().uuidString
            var record = SearchRecord(searchType: testingSearchType, timestamp: Double(Date().timeIntervalSince1970) + Double.random(in: 0 ..< 10))
            record.cityName = testingCityName
            searchHistoryManager.insertRecord(searchRecord: record)
        }
        return searchHistoryManager
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
