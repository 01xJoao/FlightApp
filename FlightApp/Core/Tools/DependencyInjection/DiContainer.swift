//
//  DiContainer.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation
import UIKit


struct DiContainer {
    private static var registrations = [AnyHashable : () -> Any]()
    private static var viewControllerRegistrations = [AnyHashable : () -> Any]()
    
    static func register<T>(_: T.Type, constructor: @escaping () -> Any) {
        let dependencyName = String(describing: T.self)
        registrations[dependencyName] = constructor
    }
    
    static func registerSingleton<T>(_: T.Type, constructor: @escaping () -> Any) {
        let dependencyName = String(describing: T.self)
        var instance: Any?
        
        let resolver: () -> Any = {
            if instance == nil {
                instance = constructor()
                return instance!
            } else {
                return instance!
            }
        }
        registrations[dependencyName] = resolver
    }
    
    static func registerViewController<T>(_: T.Type, constructor: @escaping () -> Any) {
        let dependencyName = String(describing: T.self)
        viewControllerRegistrations[dependencyName] = constructor
    }
    
    static func resolve<T>(type: T.Type = T.self) -> T {
        let dependencyName = String(describing: T.self)
        
        guard let resolver = registrations[dependencyName] else {
            fatalError("No registration for type \(dependencyName)")
        }
        
        guard let result = resolver() as? T else {
            fatalError("Can't cast registration to type \(dependencyName)")
        }
        
        return result
    }
    
    static func resolveViewController<T>(name: String) -> T {
        guard let resolver = viewControllerRegistrations[name] else {
            fatalError("No registration for type \(name)")
        }
        
        guard let result = resolver() as? T else {
            fatalError("Can't cast registration to type \(name)")
        }
        
        return result
    }
    
    static func remove<T>(type: T.Type) {
       let dependencyName = String(reflecting: T.self)
       registrations.removeValue(forKey: dependencyName)
    }
}
