//
//  FindFlight.swift
//  FlightApp
//
//  Created by João Palma on 04/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct FindFlight {
    private var _findFlight : FindFlightStruct
    
    init(_ findFlight: FindFlightStruct) {
        _findFlight = findFlight
    }
    
    func getOriginName() -> String {
        return _findFlight.originName
    }
    
    func getOriginCode() -> String {
        return _findFlight.originCode
    }
    
    func getDestinationName() -> String {
        return _findFlight.destinationName
    }
    
    func getDestinationCode() -> String {
        return _findFlight.destinationCode
    }
    
    func getDepartureDate() -> Date {
        return _findFlight.departure
    }
    
    func getDeparture() -> String {
        let df = DateFormatter()
        df.dateFormat = "d MMMM"
        let date = df.string(from: _findFlight.departure)
        return "\(date), \(String(describing: _findFlight.departure.dayOfTheWeek()!))"
    }
    
    private func _getDepartureForURL() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: _findFlight.departure)
    }
    
    func getPassengers() -> PassengersStruct {
        return _findFlight.passengers
    }
    
    func getURL() -> String {
        return "origin=\(_findFlight.originCode)&destination=\(_findFlight.destinationCode)&dateout=\(_getDepartureForURL())&\(_getPassengersForURL())&ToUs=AGREED"
    }
    
    private func _getPassengersForURL() -> String {
        return "adt=\(_findFlight.passengers.adults)&teen=\(_findFlight.passengers.teen)&chd=\(_findFlight.passengers.children)"
    }
    
    mutating func setOrigin(originName: String, originCode : String){
        _findFlight.originName = originName
        _findFlight.originCode = originCode
    }
    
    mutating func setDestination(destinationName: String, destinationCode : String){
        _findFlight.destinationName = destinationName
        _findFlight.destinationCode = destinationCode
    }
    
    mutating func setDeparture(_ date: Date) {
        _findFlight.departure = date
    }
    
    mutating func setPassengers(_ passangers: PassengersStruct) {
        _findFlight.passengers = passangers
    }
    
    mutating func swapAirports () {
        let originName = _findFlight.originName
        let originCode = _findFlight.originCode
        
        _findFlight.originName = _findFlight.destinationName
        _findFlight.originCode = _findFlight.destinationCode
        
        _findFlight.destinationName = originName
        _findFlight.destinationCode = originCode
    }
    
    mutating func clear() {
        _findFlight = FindFlightStruct()
    }
    
    mutating func clearDestination() {
        _findFlight.destinationName = ""
        _findFlight.destinationCode = ""
    }
}
