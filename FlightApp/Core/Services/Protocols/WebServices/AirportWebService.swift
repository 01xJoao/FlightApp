//
//  AirportsWebService.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

protocol AirportWebService {
    func getAvailableStations(completion: @escaping (_ airports: StationListObject?) -> Void) -> String
    func cancelRequest(id: String)
}
