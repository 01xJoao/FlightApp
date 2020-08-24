//
//  FindFlightsStruct.swift
//  FlightApp
//
//  Created by João Palma on 04/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct FindFlightStruct {
    var originName: String
    var originCode: String
    var destinationName: String
    var destinationCode: String
    var departure: Date
    var passengers: PassengersStruct

    init(originName: String = "", originCode: String = "", destinationName: String = "", destinationCode: String = "", departure: Date = Date(), passengers: PassengersStruct = PassengersStruct()) {
        self.originName = originName
        self.originCode = originCode
        self.destinationName = destinationName
        self.destinationCode = destinationCode
        self.departure = departure
        self.passengers = passengers
    }
}
