//
//  Flights.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct FlightsObject: Codable {
    let currency, serverTimeUTC: String
    let currPrecision: Int
    let trips: [TripObject]
}

struct TripObject: Codable {
    let origin, destination: String
    let dates: [DateElementObject]
}

struct DateElementObject: Codable {
    let dateOut: String
    let flights: [FlightObject]
}

struct FlightObject: Codable {
    let time: [String]
    let regularFare: FareObject
    let faresLeft: Int
    let timeUTC: [String]
    let duration, flightNumber: String
    let infantsLeft: Int
    let flightKey: String
    let businessFare: FareObject
}

struct FareObject: Codable {
    let fareKey, fareClass: String
    let fares: [FareElementObject]
}

struct FareElementObject: Codable {
    let amount: Double
    let count: Int
    let type: String
    let hasDiscount: Bool
    let publishedFare: Double
}
