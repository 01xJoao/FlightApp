//
//  PassengersStruct.swift
//  FlightApp
//
//  Created by João Palma on 04/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct PassengersStruct {
    var adults : Int
    var teen : Int
    var children : Int
    
    init(adults : Int = 1, teen : Int = 0, children : Int = 0) {
        self.adults = adults
        self.teen = teen
        self.children = children
    }
}
