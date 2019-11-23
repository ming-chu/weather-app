//
//  AppCell.swift
//  weather-app
//
//  Created by Ming Chu on 23/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation
import UIKit

enum AppCell: String {

    case searchRecordTableViewCell = "SearchRecordTableViewCell"

    var cellObj: UINib {
        return UINib(nibName: self.rawValue, bundle: nil)
    }

    var reuseIdentifier: String {
        return self.rawValue
    }
}

extension UITableView {
    func register(cell: AppCell) {
        self.register(cell.cellObj, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

extension UICollectionView {
    func register(cell: AppCell) {
        self.register(cell.cellObj, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}
