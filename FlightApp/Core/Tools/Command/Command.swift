//
//  Command.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct Command {
    private let action: () -> ()
    private let canExecuteAction: () -> (Bool)

    init(_ action: @escaping () -> (), canExecute: @escaping () -> (Bool) = {true}) {
        self.action = action
        self.canExecuteAction = canExecute
    }

    func execute() {
        action()
    }
    
    func executeIf() {
        if(canExecuteAction()) {
            action()
        }
    }
    
    func canExecute() -> Bool {
        return canExecuteAction()
    }
}
