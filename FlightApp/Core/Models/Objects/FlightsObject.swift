//
//  Flights.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct FlightsObject: Codable {
    let termsOfUse: String
    let currPrecision: Double
    let routeGroup: String
    let tripType: String
    let currency: String
    let serverTimeUTC: String
    let upgradeType: String
    let trips: [TripObject]
}

struct TripObject: Codable {
    let origin, originName, destination, destinationName: String
    let routeGroup, tripType, upgradeType: String
    let dates: [DateElementObject]
}

struct DateElementObject: Codable {
    let dateOut: String
    let flights: [FlightObject]
}

struct FlightObject: Codable {
    let faresLeft: Double
    let flightKey: String
    let infantsLeft: Double
    let regularFare: RegularFareObject?
    let operatedBy: String
    let segments: [SegmentObject]
    let flightNumber: String
    let time, timeUTC: [String]
    let duration: String
}

struct RegularFareObject: Codable {
    let fareKey, fareClass: String
    let fares: [FareObject]
}

struct FareObject: Codable {
    let type: String
    let amount, count: Double
    let hasDiscount: Bool
    let publishedFare, discountInPercent: Double
    let hasPromoDiscount: Bool
    let discountAmount: Double
}

struct SegmentObject: Codable {
    let segmentNr: Int
    let origin, destination, flightNumber: String
    let time, timeUTC: [String]
    let duration: String
}
