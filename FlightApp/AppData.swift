//
//  AppEndPoints.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct AppEndPoints {
    static let stations = "https://tripstest.ryanair.com/"
    static let flights = "https://sit-nativeapps.ryanair.com/api/v4/Availability?"
}

struct FlightValues {
    static let minAdultsPassenger : Double = 1
    static let maxPerPassengerPerType : Double = 6
}
