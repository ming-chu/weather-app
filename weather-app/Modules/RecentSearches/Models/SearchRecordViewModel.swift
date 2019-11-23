//
//  SearchRecordViewModel.swift
//  weather-app
//
//  Created by Ming Chu on 23/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation

struct SearchRecordViewModel: SearchRecordTableViewCellViewModel {

    let searchRecord: SearchRecord

    var recordId: String {
        return searchRecord.recordId
    }

    var queryDetails: String {
        guard let desc = self.searchRecord.queryType?.description else { return "" }
        return desc
    }

    var datetime: String {
        let ts = self.searchRecord.timestamp
        return Date(timeIntervalSince1970: ts).dateString(format: "HH:mm, dd MMM yyyy") //13:34, 5 May 2019
    }

}
