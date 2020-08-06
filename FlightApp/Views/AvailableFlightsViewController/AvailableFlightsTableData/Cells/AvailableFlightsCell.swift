//
//  AvailableFlightsCell.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class FlightCell : UITableViewCell {
    public func config(_ flight : FlightDetail) {
        self.removeAllSubViews()
        _createCard(flight)
    }
    
    private func _createCard(_ flight : FlightDetail) {
    }
}

