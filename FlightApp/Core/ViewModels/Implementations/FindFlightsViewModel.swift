//
//  FindFlightsViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

public class FindFlightsViewModel : ViewModelBase {
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    //L10N Strings
    public let findFlightsTitleLabel: String = L10N.localize(key: "findflights_title")
    public let departureLabel: String = L10N.localize(key: "findflights_departure")
    public let passengersLabel: String = L10N.localize(key: "findflights_passengers")
    public let originLabel: String = L10N.localize(key: "findflights_origin")
    public let destinationLabel: String = L10N.localize(key: "findflights_destination")
    public let letsGoLabel: String = L10N.localize(key: "findflights_find")
    public let clearLabel: String = L10N.localize(key: "global_clear")
}
