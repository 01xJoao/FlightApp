//
//  FindFlightsWebService.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

protocol FindFlightsWebService {
    func findAvailableFlights(findFlight : FindFlight, completion: @escaping (_ flights: FlightsStruct?) -> Void) -> String
    func cancelRequest(id: String)
}
