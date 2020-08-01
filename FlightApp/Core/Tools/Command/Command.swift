//
//  Command.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public struct Command {
    private let action: () -> ()
    private let canExecuteAction: () -> (Bool)

    init(_ action: @escaping () -> (), canExecute: @escaping () -> (Bool) = {true}) {
        self.action = action
        self.canExecuteAction = canExecute
    }

    public func execute() {
        action()
    }
    
    public func executeIf() {
        if(canExecuteAction()) {
            action()
        }
    }
    
    public func canExecute() -> Bool {
        return canExecuteAction()
    }
}
