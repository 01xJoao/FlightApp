//
//  CountryListViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class CountryListViewModel : ViewModelBase {
    private var _title: String?
    public var title : String {
        get {
            return _title!
        }
    }
    
    public override func prepare(dataObject: Any) {
        let flightType = dataObject as! FlightCountryType
        
        _title = flightType == FlightCountryType.origin ? originLabel : destinationLabel
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    //L10N Strings
    private let originLabel: String = L10N.localize(key: "findflights_origin")
    private let destinationLabel: String = L10N.localize(key: "findflights_destination")
    public let searchLabel: String = L10N.localize(key: "global_search")
    
}
