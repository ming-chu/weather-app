//
//  MockUserDefaults.swift
//  weather-appTests
//
//  Created by Ming Chu on 23/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

class MockUserDefaults : UserDefaults {
    convenience init() {
        self.init(suiteName: "MockUserDefaults")!
    }

    override init?(suiteName suitename: String?) {
        UserDefaults().removePersistentDomain(forName: suitename!)
        super.init(suiteName: suitename)
    }
}
