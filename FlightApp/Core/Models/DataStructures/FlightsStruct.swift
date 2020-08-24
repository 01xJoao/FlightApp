//
//  FlightsStruct.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct FlightsStruct: Codable {
    let termsOfUse: String
    let currPrecision: Double
    let routeGroup: String
    let tripType: String
    let currency: String
    let serverTimeUTC: String
    let upgradeType: String
    let trips: [TripStruct]
}

struct TripStruct: Codable {
    let origin, originName, destination, destinationName: String
    let routeGroup, tripType, upgradeType: String
    let dates: [DateElementStruct]
}

struct DateElementStruct: Codable {
    let dateOut: String
    let flights: [FlightStruct]
}

struct FlightStruct: Codable {
    let faresLeft: Double
    let flightKey: String
    let infantsLeft: Double
    let regularFare: RegularFareStruct?
    let operatedBy: String
    let segments: [SegmentStruct]
    let flightNumber: String
    let time, timeUTC: [String]
    let duration: String
}

struct RegularFareStruct: Codable {
    let fareKey, fareClass: String
    let fares: [FareStruct]
}

struct FareStruct: Codable {
    let type: String
    let amount, count: Double
    let hasDiscount: Bool
    let publishedFare, discountInPercent: Double
    let hasPromoDiscount: Bool
    let discountAmount: Double
}

struct SegmentStruct: Codable {
    let segmentNr: Int
    let origin, destination, flightNumber: String
    let time, timeUTC: [String]
    let duration: String
}
