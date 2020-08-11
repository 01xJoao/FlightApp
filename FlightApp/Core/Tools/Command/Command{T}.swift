//
//  WpCommand.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

struct WPCommand<T> {
    private let actionWithParam: (T) -> ()
    private let canExecuteAction: () -> (Bool)

    init(_ actionWithParam: @escaping (T) -> (), canExecute: @escaping () -> (Bool) = {true}) {
        self.actionWithParam = actionWithParam
        self.canExecuteAction = canExecute
    }

    func execute(_ value: T) {
        actionWithParam(value)
    }

    func executeIf(_ value: T) {
        if(canExecuteAction()) {
           actionWithParam(value)
        }
    }

    func canExecute() -> Bool {
        return canExecuteAction()
    }
}
