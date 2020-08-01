//
//  ReportService.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

protocol ReportService {
    func sendError(error: Error, message: String?)
    func sendEvent(message: String)
}
