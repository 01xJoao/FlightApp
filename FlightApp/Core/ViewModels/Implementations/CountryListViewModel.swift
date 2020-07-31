//
//  CountryListViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class CountryListViewModel : ViewModelBase {
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
}
