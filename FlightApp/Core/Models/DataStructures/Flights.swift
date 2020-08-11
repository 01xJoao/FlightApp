//
//  Flights.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct Flights {
    private var _flights: FlightsObject
    
    init(_ flights: FlightsObject) {
        _flights = flights
    }
    
    func getOriginName() -> String {
        return _flights.trips.first?.originName ?? ""
    }
    
    func getOriginCode() -> String {
        return _flights.trips.first?.origin ?? ""
    }
    
    func getDestinationName() -> String {
        return _flights.trips.first?.destinationName ?? ""
    }
    
    func getDestinationCode() -> String {
        return _flights.trips.first?.destination ?? ""
    }
    
    func getDeparture() -> String {
        let date = DateFormatter.date(fromISO8601String: _flights.trips.first?.dates.first?.dateOut ?? "")!
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMM yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    func getFlights() -> [FlightDetail] {
        var flights: [FlightDetail] = []
        
        _flights.trips.first?.dates.first?.flights.forEach { flight in
            flights.append(FlightDetail(flight, currency: _flights.currency))
        }
        
        return flights
    }
}
