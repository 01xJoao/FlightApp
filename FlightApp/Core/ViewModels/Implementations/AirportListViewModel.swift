//
//  CountryListViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class AirportListViewModel : ViewModelBase {
    private var _flightAirportType : FlightAirportType!
    
    private(set) var title: String!
    private(set) var airports : DynamicValueList<Airport>!
    private(set) var airportSearchList : DynamicValueList<Airport> = DynamicValueList<Airport>()
    
    private var _searchCommand : WPCommand<String>?
    var searchCommand: WPCommand<String> {
        get {
            _searchCommand ??= WPCommand<String>(_search)
            return _searchCommand!
        }
    }
    
    private var _closeViewCommand : WPCommand<String>?
    var closeViewCommand: WPCommand<String> {
        get {
            _closeViewCommand ??= WPCommand<String>(_closeView)
            return _closeViewCommand!
        }
    }
    
    override func prepare(dataObject: Any) {
        let airportSearch = dataObject as! AirportSearchStruct
        title = airportSearch.flightAirportType == FlightAirportType.origin ? originLabel : destinationLabel
        _flightAirportType = airportSearch.flightAirportType
        airports = airportSearch.airports!
        _createAirportList(market: airportSearch.market!)
    }
    
    private func _createAirportList(market : String) {
        if(market.isEmpty) {
            return
        }
        
        if(_flightAirportType == FlightAirportType.destination) {
            airports?.data.value.removeAll(where: { !$0.containsMarket(market) })
        }
    }
    
    private func _search(search : String) {
        let airportSeachList = airports!.data.value.filter { airport in airport.containSearch(search) }
        
        airportSearchList.data.value.removeAll()
        airportSearchList.addAll(object: airportSeachList)
    }
    
    private func _closeView(airportCode : String) {
        let obj = AirportSearchStruct(airports: nil, market: airportCode, flightAirportType: _flightAirportType)
        navigationService.closeModal(arguments: obj)
    }
    
    //L10N Strings
    private let originLabel: String = L10N.localize(key: "findflights_origin")
    private let destinationLabel: String = L10N.localize(key: "findflights_destination")
    let searchLabel: String = L10N.localize(key: "global_search")
    
}
