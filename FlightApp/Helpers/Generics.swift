//
//  Generics.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

typealias EventHandler = (Any) -> (Any)

infix operator ??=
func ??= <T>(left: inout T?, right: T) {
    left = left ?? right
}

public class DynamicValueList<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    
    func add(object: T) {
        data.value.append(object)
    }
    
    func addAll(object: [T]) {
        data.value.append(contentsOf: object)
    }
    
    func remove(at: Int) {
        data.value.remove(at: at)
    }
    
    func removeAll() {
        data.value.removeAll()
    }
    
    func notifyList() {
        data.notify()
    }
}
