//
//  Utils.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import ImageLoader

public struct Utils {
    //public let keyWindow: UIWindow = UIApplication.shared.windows.first {$0.isKeyWindow}!
    
    public static func serializeJson<T : Codable>(object: T) -> NSDictionary {
        let jsonData = try? JSONEncoder().encode(object)
        let jsonResult = try? JSONSerialization.jsonObject(with: jsonData!) as? NSDictionary
        return jsonResult ?? ["" : ""]
    }
    
//    public static func loadWebImage(imageUrl : String!) -> UIImageView {
////        print("Entrou")
////        if(imageUrl.isEmpty) {
////            return UIImage()
////        }
////
////        let url = URL(string: imageUrl)!
////        let data = try? Data(contentsOf: url)
////
////        if let imageData = data {
////            let image = UIImage(data: imageData)
////            return image!
////        } else {
////            return UIImage()
////        }
//        
//        if(imageUrl.isEmpty) {
//            return UIImage()
//        }
//        
//    }
}
