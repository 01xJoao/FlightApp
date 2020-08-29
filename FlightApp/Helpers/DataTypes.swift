//
//  Generics.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

typealias CompletionHandler = () -> Void
typealias CompletionHandlerWithParam<T> = (T) -> Void
typealias CanExecuteCompletionHandler = () -> (Bool)

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}
