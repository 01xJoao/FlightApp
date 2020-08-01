//
//  Extensions.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}
