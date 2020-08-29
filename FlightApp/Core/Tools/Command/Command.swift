//
//  Command.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct Command {
    private var action : CompletionHandler
    private let canExecuteAction : CanExecuteCompletionHandler

    init(_ action: @escaping CompletionHandler, canExecute: @escaping CanExecuteCompletionHandler = { true }) {
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
