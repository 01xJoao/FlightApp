//
//  Enums.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
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

public enum FlightAirportType {
    case origin
    case destination
}

public enum InfoDialogType {
    case good
    case bad
    case info
}

extension InfoDialogType: RawRepresentable {
    public typealias RawValue = UIColor

    public init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.Theme.green: self = .good
        case UIColor.Theme.red: self = .bad
        case UIColor.Theme.darkBlue: self = .info
        default: return nil
        }
    }

public var rawValue: RawValue {
        switch self {
        case .good: return UIColor.Theme.green
        case .bad: return UIColor.Theme.red
        case .info: return UIColor.Theme.darkBlue
        }
    }
}
