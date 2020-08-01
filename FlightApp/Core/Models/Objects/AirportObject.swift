//
//  AirportObject.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct StationListObject: Codable {
    let stations: [AirportObject]
}

struct AirportObject : Codable {
    let code : String
    let name : String
    let alias: [String]
    let countryName : String
    let latitude : String
    let longitude : String
    let tripCardImageURL: String?
    let markets: [MarketObject]
}

struct MarketObject: Codable {
    let code: String
}
