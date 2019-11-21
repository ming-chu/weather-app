//
//  Extensions.swift
//  weather-app
//
//  Created by Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

extension String {
    var containsNumbersOnly: Bool {
        return CharacterSet(charactersIn: self).isSubset(of: CharacterSet.decimalDigits)
    }
}

extension Date {
    func dateString(format: String = "HH:mm MMM dd") -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
}
