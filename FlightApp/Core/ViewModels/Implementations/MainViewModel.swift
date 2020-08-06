//
//  MainViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class MainViewModel : ViewModelBase {
    private let _airportWebService : AirportWebService
    
    private let _airports: DynamicValueList<Airport> = DynamicValueList<Airport>()
    public var airports : DynamicValueList<Airport> {
        get {
            return _airports
        }
    }
    
    init(airportWebService: AirportWebService) {
        self._airportWebService = airportWebService
    }
    
    public override func initialize() {
        _fetchStations()
    }
    
    private func _fetchStations() {
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
        
        _airports.addAll(object: airportList)
        
        isBusy.value = false
    }
    
    public let findFlightsTitleLabel: String = L10N.localize(key: "findflights_title")
    public let airportsTitleLabel: String = L10N.localize(key: "airports_title")
}
