//
//  Airport.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct Airport {
    private var _airport: AirportObject
    
    init(_ airport: AirportObject) {
        _airport = airport
    }
    
    public func getCode() -> String {
        return _airport.code
    }
    
    public func getName() -> String {
        return _airport.name
    }
    
    public func getAlias() -> [String] {
        return _airport.alias
    }
    
    public func getCountryName() -> String {
        return _airport.countryName.uppercased()
    }
    
    public func getLatitude() -> String {
        return _airport.latitude
    }
    
    public func getLongitude() -> String {
        return _airport.longitude
    }
    
    public func getImageUrl() -> URL? {
        if(_airport.tripCardImageUrl != nil) {
            return URL(string: _airport.tripCardImageUrl!)
        }
        
        return nil
    }
    
    public func getMarkets() -> [Market] {
        var marketList: [Market]!
        
        _airport.markets.forEach { market in
            marketList.append(Market(market))
        }
        
        return marketList
    }
    
    public func containSearch(_ searchString: String) -> Bool {
        if(searchString.isEmpty) {
            return true
        }
        
        if(_airport.name.lowercased().contains(searchString.lowercased())) {
            return true
        }
        
        if(_airport.code.lowercased().contains(searchString.lowercased())) {
            return true
        }
        
        return false
    }
}
