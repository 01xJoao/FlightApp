//
//  Airport.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

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
    
    public func getLatitude() -> String {
        return _airport.latitude
    }
    
    public func getLongitude() -> String {
        return _airport.longitude
    }
    
    public func getImageUrl() -> String? {
        return _airport.tripCardImageUrl ?? ""
    }
    
    public func getMarkets() -> [Market] {
        var marketList: [Market]!
        
        _airport.markets.forEach { market in
            marketList.append(Market(market))
        }
        
        return marketList
    }
}
