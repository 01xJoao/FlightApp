//
//  AvailableFlightsViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

public class AvailableFlightsViewModel : ViewModelBase {
    
    
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
