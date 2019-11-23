//
//  Extensions.swift
//  weather-app
//
//  Created by Ming Chu on 20/11/2019.
//  Copyright © 2019 vegantell. All rights reserved.
//

import Foundation
import UIKit

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

extension Bundle {
    func getValue<T>(forKey key: String, forResource resource: String = "Info", ofType type: String = "plist") -> T? {
        guard let path = self.path(forResource: resource, ofType: type) else { return nil }
        guard let dictionary = NSDictionary(contentsOfFile: path) else { return nil }
        return dictionary[key] as? T
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
          let cornerMasks = [
              corners.contains(.topLeft) ? CACornerMask.layerMinXMinYCorner : nil,
              corners.contains(.topRight) ? CACornerMask.layerMaxXMinYCorner : nil,
              corners.contains(.bottomLeft) ? CACornerMask.layerMinXMaxYCorner : nil,
              corners.contains(.bottomRight) ? CACornerMask.layerMaxXMaxYCorner : nil,
              corners.contains(.allCorners) ? [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner] : nil
          ].compactMap({ $0 })

          var maskedCorners: CACornerMask = []
          cornerMasks.forEach { (mask) in maskedCorners.insert(mask) }

          if #available(iOS 11.0, *) {
              self.clipsToBounds = true
              self.layer.cornerRadius = radius
              self.layer.maskedCorners = maskedCorners
          } else {
              let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
              let mask = CAShapeLayer()
              mask.path = path.cgPath
              self.layer.mask = mask
          }
      }
}
