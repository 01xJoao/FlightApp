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
}
