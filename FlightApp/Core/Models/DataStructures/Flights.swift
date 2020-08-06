//
//  Flights.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct Flights {
    private var _flights: FlightsObject
    
    init(_ flights: FlightsObject) {
        _flights = flights
    }
    
    public func getOriginName() -> String {
        return _flights.trips.first?.origin ?? ""
    }
    
    public func getOriginCode() -> String {
        return _flights.trips.first?.destination ?? ""
    }
    
    public func getDestinationName() -> String {
        return _flights.trips.first?.destinationName ?? ""
    }
    
    public func getDestinationCode() -> String {
        return _flights.trips.first?.destinationName ?? ""
    }
    
    public func getDeparture() -> String {
        let date = Utils.getDateFromIso(_flights.trips.first?.dates.first?.dateOut ?? "")
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMM yyyy"
        return dateFormatterPrint.string(from: date)
    }
    
    public func getFlights() -> [FlightDetail] {
        var flights: [FlightDetail]!
        
        _flights.trips.first?.dates.first?.flights.forEach { flight in
            flights.append(FlightDetail(flight, currency: _flights.currency))
        }
        
        return flights
    }
}
