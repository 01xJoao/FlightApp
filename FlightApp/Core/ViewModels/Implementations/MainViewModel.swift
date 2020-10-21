//
//  MainViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class MainViewModel : ViewModelBase {
    private let _airportWebService : AirportWebService
    
    private(set) var airports: DynamicValueList<Airport> = DynamicValueList<Airport>()
    
    init(airportWebService: AirportWebService) {
        self._airportWebService = airportWebService
    }
    
    override func initialize() {
        _fetchStations()
    }
    
    private func _fetchStations() {
        isBusy.value = true
        
        DispatchQueue.main.async {
            _ = self._airportWebService.getAvailableStations(completion: { [weak self] stationList in
                self?._airportsCompletion(stationList)
            })
        }
    }
    
    private func _airportsCompletion(_ stationList : StationListStruct?) {
        var airportList: [Airport] = []
        
        stationList?.stations?.forEach{ airport in
            airportList.append(Airport(airport))
        }
        
        airports.addAll(object: airportList)
        
        isBusy.value = false
    }
    
    let findFlightsTitleLabel: String = L10N.localize(key: "findflights_title")
    let airportsTitleLabel: String = L10N.localize(key: "airports_title")
}
