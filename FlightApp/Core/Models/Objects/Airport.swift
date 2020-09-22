//
//  Airport.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct Airport {
    private var _airport: AirportStruct
    
    init(_ airport: AirportStruct) {
        _airport = airport
    }
    
    func getCode() -> String {
        return _airport.code
    }
    
    func getName() -> String {
        return _airport.name
    }
    
    func getAlias() -> [String] {
        return _airport.alias
    }
    
    func getCountryName() -> String {
        return _airport.countryName
    }
    
    func getLatitude() -> String {
        return _airport.latitude
    }
    
    func getLongitude() -> String {
        return _airport.longitude
    }
    
    func getImageUrl() -> URL? {
        if let url = _airport.tripCardImageUrl {
            return URL(string: url)
        }
        
        return nil
    }
    
    func getMarkets() -> [Market] {
        var marketList: [Market]!
        
        _airport.markets.forEach { market in
            marketList.append(Market(market))
        }
        
        return marketList
    }
    
    func containsMarket(_ market : String) -> Bool {
        if _airport.markets.contains(where: { $0.code == market }) {
            return true
        }
        
        return false
    }
    
    
    func containSearch(_ searchString: String) -> Bool {
        if(searchString.isEmpty) {
            return true
        }
        
        if(_airport.name.lowercased().contains(searchString.lowercased())) {
            return true
        }
        
        if(_airport.code.lowercased().contains(searchString.lowercased())) {
            return true
        }
        
        if(_airport.countryName.lowercased().contains(searchString.lowercased())) {
            return true
        }
        
        return false
    }
}
