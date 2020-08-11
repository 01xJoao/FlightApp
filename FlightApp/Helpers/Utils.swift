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

public struct Utils {
    public static let keyWindow: UIWindow = UIApplication.shared.windows.first {$0.isKeyWindow}!
    
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
}
