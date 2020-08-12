//
//  ViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

protocol ViewModel {
    func prepare(dataObject: Any)
    func initialize()
    func appearing()
    func disappearing()
    func backAction()
    func dataNotify(dataObject: Any?)
}
