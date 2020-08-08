//
//  AvailableFlightsViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

public class AvailableFlightsViewModel : ViewModelBase {
    private var _flights : Flights!
    public var flights : Flights {
        get {
            return _flights
        }
    }
    
    public override func prepare(dataObject: Any) {
        if let flights = dataObject as? FlightsObject {
            _setFlights(flights)
        }
    }
    
    private func _setFlights(_ flights : FlightsObject) {
        _flights = Flights(flights)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    //L10N
    public let titleLabel = L10N.localize(key: "availableflights_title")
    public let departLabel = L10N.localize(key: "availableflights_depart")
    public let arriveLabel = L10N.localize(key: "availableflights_arrive")
    public let flightNrLabel = L10N.localize(key: "availableflights_flight")
    public let noAvailableFlightsLabel = L10N.localize(key: "availableflights_noflights")
    public let soldOutLabel = L10N.localize(key: "availableflights_soldout")
    public let hrsLabel = L10N.localize(key: "global_hours")
    public let minsLabel = L10N.localize(key: "global_minutes")
}
