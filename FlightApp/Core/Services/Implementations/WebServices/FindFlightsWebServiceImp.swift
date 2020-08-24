//
//  FindFlightsWebServiceImp.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class FindFlightsWebServiceImp : FindFlightsWebService {
    private let _webService: WebService
    
    init(webService: WebService) {
        self._webService = webService
    }
    
    func findAvailableFlights(findFlight: FindFlight, completion: @escaping (FlightsStruct?) -> Void) -> String {
        let cancelationToken = _webService.getRequest(baseUrl: .flights, requestUri: findFlight.getURL(), completion: { flights in completion(flights) })
        return cancelationToken
    }
    
    func cancelRequest(id: String) {
        _webService.cancelRequest(id)
    }
}
