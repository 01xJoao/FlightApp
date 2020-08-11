//
//  CountrySearchObject.swift
//  FlightApp
//
//  Created by João Palma on 04/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct AirportSearchObject {
    let airports : DynamicValueList<Airport>?
    let market : String?
    let flightAirportType : FlightAirportType
    
    init(airports : DynamicValueList<Airport>?, market : String?, flightAirportType : FlightAirportType) {
        self.airports = airports
        self.market = market
        self.flightAirportType = flightAirportType
    }
}
