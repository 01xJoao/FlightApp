//
//  Utils.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import ImageLoader
import Foundation

typealias EventHandler = (Any) -> (Any)

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}

public struct Utils {
    //public let keyWindow: UIWindow = UIApplication.shared.windows.first {$0.isKeyWindow}!
    
    public static func serializeJson<T : Codable>(object: T) -> NSDictionary {
        let jsonData = try? JSONEncoder().encode(object)
        let jsonResult = try? JSONSerialization.jsonObject(with: jsonData!) as? NSDictionary
        return jsonResult ?? ["" : ""]
    }
    
    
    public static func splitHoursString(_ hour : String) -> [String] {
        if(hour.isEmpty) {
            return ["", ""]
        }
        
        let split = hour.split(separator: ":")
        return [String(split[0]), String(split[1])]
    }
    
    public static func getDateFromIso(_ isoDate : String) -> Date {
        if(isoDate.isEmpty) {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: isoDate)!
        
        return date
    }
}

