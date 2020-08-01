//
//  Enums.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

enum baseURL : String {
    case stations
    case flights
    
    var url: String {
        switch self {
        case .stations:
            return AppEndPoints.stations
        case .flights:
            return AppEndPoints.flights
        }
    }
}
