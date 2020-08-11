//
//  FlightDetail.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct FlightDetail {
    private var _flight: FlightObject
    private var _currency : String
    
    init(_ flights: FlightObject, currency : String) {
        _flight = flights
        _currency = currency
    }
    
    func getDepartTime() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm"
        let date = DateFormatter.date(fromISO8601String: _flight.time.first ?? "")!
        return dateFormatterPrint.string(from: date)
    }
    
    func getArriveTime() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "hh:mm"
         let date = DateFormatter.date(fromISO8601String: _flight.time.last ?? "")!
        return dateFormatterPrint.string(from: date)
    }
    
    func getDurationTime() -> String {
        return "\(_flight.duration)"
    }
    
    func getFlightNumber() -> String {
        return _flight.flightNumber
    }
    
    func getFare() -> String {
        if(_flight.regularFare?.fares.first?.amount ?? 0 > 0) {
            return "\(_flight.regularFare?.fares.first?.amount ?? 0)"
        }
        
        return ""
    }
    
    func getCurrency() -> String {
        return _currency
    }
}
