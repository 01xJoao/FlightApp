//
//  FlightDetail.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct FlightDetail {
    private var _flight: FlightObject
    private var _currency : String
    
    init(_ flights: FlightObject, currency : String) {
        _flight = flights
        _currency = currency
    }
    
    public func getDepartTime() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm"
        let date = DateFormatter.date(fromISO8601String: _flight.time.first ?? "")!
        return dateFormatterPrint.string(from: date)
    }
    
    public func getArriveTime() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm"
         let date = DateFormatter.date(fromISO8601String: _flight.time.first ?? "")!
        return dateFormatterPrint.string(from: date)
    }
    
    public func getDurationTime() -> String {
        return "\(_flight.duration) hrs"
    }
    
    public func getFlightNumber() -> String {
        return _flight.flightNumber
    }
    
    public func getFare() -> String {
        return "\(Int(_flight.regularFare.fares.first?.amount ?? 0))"
    }
    
    public func getCurrency() -> String {
        return _currency
    }
}
