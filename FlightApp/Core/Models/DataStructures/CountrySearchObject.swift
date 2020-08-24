//
//  CountrySearchObject.swift
//  FlightApp
//
//  Created by João Palma on 04/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct AirportSearchObject {
    public let airports : [Airport]
    public let market : String?
    public let flightcountryType : FlightCountryType
    
    init(airports : [Airport], market : String?, flightcountryType : FlightCountryType) {
        self.airports = airports
        self.market = market
        self.flightcountryType = flightcountryType
    }
}
