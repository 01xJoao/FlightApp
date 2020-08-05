//
//  FindFlight.swift
//  FlightApp
//
//  Created by João Palma on 04/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct FindFlight {
    private var _findFlight : FindFlightObject
    
    init(_ findFlight: FindFlightObject) {
        _findFlight = findFlight
    }
    
    public func getOriginName() -> String {
        return _findFlight.originName
    }
    
    public func getOriginCode() -> String {
        return _findFlight.originCode
    }
    
    public func getDestinationName() -> String {
        return _findFlight.destinationName
    }
    
    public func getDestinationCode() -> String {
        return _findFlight.destinationCode
    }
    
    public func getDeparture() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd MM"
        
        var date = df.string(from: _findFlight.departure)
        
        date = "\(date), \(String(describing: _findFlight.departure.dayOfTheWeek()))"
        
        return date
    }
    
    public func getDepartureForURL() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-mm-dd"
        return df.string(from: _findFlight.departure)
    }
    
    public func getPassengers() -> Passangers {
        return _findFlight.passengers
    }
    
    public mutating func setOrigin(originName: String, originCode : String){
        _findFlight.originName = originName
        _findFlight.originCode = originCode
    }
    
    public mutating func setDestination(destinationName: String, destinationCode : String){
        _findFlight.destinationName = destinationName
        _findFlight.destinationCode = destinationCode
    }
    
    public mutating func setDeparture(_ date: Date) {
        _findFlight.departure = date
    }
    
    public mutating func setPassengers(_ passangers: Passangers) {
        _findFlight.passengers = passangers
    }
    
    public mutating func swapAirports () {
        let originName = _findFlight.originName
        let originCode = _findFlight.originCode
        
        _findFlight.originName = _findFlight.destinationName
        _findFlight.originCode = _findFlight.destinationCode
        
        _findFlight.destinationName = originName
        _findFlight.originCode = originCode
    }
    
    public mutating func clear() {
        _findFlight = FindFlightObject()
    }
}
