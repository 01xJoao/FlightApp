//
//  AirportsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class AirportsViewModel : ViewModelBase {
    private let _airportWebService : AirportWebService
    
    public var airports: DynamicValueList<Airport> = DynamicValueList<Airport>()
    
    init(airportWebService: AirportWebService) {
        self._airportWebService = airportWebService
    }
    
    public override func initialize() {
        do {
            try _fetchStations()
        } catch let error {
            reportService.sendError(error: error, message: "Error fetching airports")
        }
        
    }
    
    private func _fetchStations() throws {
        isBusy.value = true
        
        DispatchQueue.main.async {
            _ = self._airportWebService.getAvailableStations(completion: { stationList in self._airportsCompletion(stationList) })
        }
    }
    
    private func _airportsCompletion(_ stationList : StationListObject?) {
        var airportList: [Airport] = []
        
        stationList?.stations?.forEach{ airport in
            airportList.append(Airport(airport))
        }
        
        airports.addAll(object: airportList)
        isBusy.value = false
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
