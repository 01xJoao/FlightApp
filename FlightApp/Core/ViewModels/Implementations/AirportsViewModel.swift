//
//  AirportsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class AirportsViewModel : ViewModelBase {
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
            _searchCommand ??= WPCommand<String>(_search, canExecute: _canExecute)
            return _searchCommand!
        }
    }

    public override func prepare(dataObject: Any) {
        _airports = (dataObject as! DynamicValueList<Airport>)
    }
    
    private func _search(search : String) {
        let airportSeachList = _airports!.data.value.filter { airport in airport.containSearch(search) }
        
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
