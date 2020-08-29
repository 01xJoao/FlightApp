//
//  DynamicValue.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class DynamicValue<T> {
    private var _observers = [String: CompletionHandler]()
    var value : T { didSet { notify() } }
    
    init(_ value: T) {
        self.value = value
    }
    
    func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        print(observer.description)
        _observers[observer.description] = completionHandler
    }
    
    func addAndNotify(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        addObserver(observer, completionHandler: completionHandler)
        notify()
    }
    
    func notify() {
        _observers.forEach({ $0.value() })
    }
    
    deinit {
        _observers.removeAll()
    }
}
