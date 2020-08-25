//
//  AirportsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class AirportsViewModel : ViewModelBase {
    private(set) var airports : DynamicValueList<Airport>!
    private(set) var airportSearchList : DynamicValueList<Airport> = DynamicValueList<Airport>()

    private var _searchCommand: WPCommand<String>?
    var searchCommand: WPCommand<String> {
        get {
            _searchCommand ??= WPCommand<String>(_search, canExecute: _canExecute)
            return _searchCommand!
        }
    }

    override func prepare(dataObject: Any) {
        airports = (dataObject as! DynamicValueList<Airport>)
    }
    
    private func _search(search : String) {
        let airportSeachList = airports!.data.value.filter { airport in airport.containSearch(search) }
        
        airportSearchList.data.value.removeAll()
        airportSearchList.addAll(object: airportSeachList)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    //L10N Strings
    let airportsTitleLabel: String = L10N.localize(key: "airports_title")
    let searchLabel: String = L10N.localize(key: "global_search")
}
