//
//  AirportWebServiceImp.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class AirportWebServiceImp : AirportWebService {
    private let _webService: WebService
    
    init(webService: WebService) {
        self._webService = webService
    }
    
    func getAvailableStations(completion: @escaping (_ airports: StationListObject?) -> Void) -> String {
        let cancelationToken = _webService.getRequest(baseUrl: .stations, requestUri: "static/stations.json", completion: { airports in completion(airports) })
        return cancelationToken
    }
    
    func cancelRequest(id: String) {
        _webService.cancelRequest(id)
    }
}
