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
    
    private let _airports: DynamicValueList<Airport> = DynamicValueList<Airport>()
    private var _airportSearchList : DynamicValueList<Airport> = DynamicValueList<Airport>()
    
    public var airports : DynamicValueList<Airport> {
        get {
            return _airports
        }
    }
    
    public var searchAirports : DynamicValueList<Airport> {
           get {
               return _airportSearchList
           }
       }
    
    private var _searchCommand: WPCommand<String>?
    public var searchCommand: WPCommand<String> {
        get {
            _searchCommand ??= WPCommand<String>(_search, canExecute: _canExecute)
            return _searchCommand!
        }
    }
    
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
        isBusy.value = false
        
        var airportList: [Airport] = []
        
        stationList?.stations?.forEach{ airport in
            airportList.append(Airport(airport))
        }
        
        _airports.addAll(object: airportList)
    }
    
    private func _search(search : String) {
        let airportSeachList = _airports.data.value.filter { airport in airport.containSearch(search) }
        
        _airportSearchList.data.value.removeAll()
        _airportSearchList.addAll(object: airportSeachList)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    //L10N Strings
    public let airportsTitleLabel: String = L10N.localize(key: "airports_title")
    public let searchLabel: String = L10N.localize(key: "global_search")
}
