//
//  CountryListViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class AirportListViewModel : ViewModelBase {
    private var _flightAirportType : FlightAirportType!
    
    private var _title: String?
    public var title : String {
        get {
            return _title!
        }
    }
    
    private var _airports : DynamicValueList<Airport>!
    public var airports : DynamicValueList<Airport> {
        get {
            return _airports
        }
    }
    
    private var _airportSearchList : DynamicValueList<Airport> = DynamicValueList<Airport>()
    public var searchAirports : DynamicValueList<Airport> {
        get {
           return _airportSearchList
       }
    }
    
    private var _searchCommand: WPCommand<String>?
    public var searchCommand: WPCommand<String> {
        get {
            _searchCommand ??= WPCommand<String>(_search)
            return _searchCommand!
        }
    }
    
    private var _closeViewCommand: WPCommand<String>?
    public var closeViewCommand: WPCommand<String> {
        get {
            _closeViewCommand ??= WPCommand<String>(_closeView)
            return _closeViewCommand!
        }
    }
    
    public override func prepare(dataObject: Any) {
        let airportSearch = dataObject as! AirportSearchObject
        _title = airportSearch.flightAirportType == FlightAirportType.origin ? originLabel : destinationLabel
        _flightAirportType = airportSearch.flightAirportType
        _airports = airportSearch.airports!
        
        _createAirportList(market: airportSearch.market!)
    }
    
    private func _createAirportList(market : String) {
        if(_flightAirportType == FlightAirportType.destination) {
            _airports?.data.value.removeAll(where: { $0.containsMarket(market) })
        }
    }
    
    private func _search(search : String) {
        let airportSeachList = _airports!.data.value.filter { airport in airport.containSearch(search) }
        
        _airportSearchList.data.value.removeAll()
        _airportSearchList.addAll(object: airportSeachList)
    }
    
    private func _closeView(airportCode : String) {
        let obj = AirportSearchObject(airports: nil, market: airportCode, flightAirportType: _flightAirportType)
        navigationService.closeModal(arguments: obj)
    }
    
    //L10N Strings
    private let originLabel: String = L10N.localize(key: "findflights_origin")
    private let destinationLabel: String = L10N.localize(key: "findflights_destination")
    public let searchLabel: String = L10N.localize(key: "global_search")
    
}
