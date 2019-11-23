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

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
