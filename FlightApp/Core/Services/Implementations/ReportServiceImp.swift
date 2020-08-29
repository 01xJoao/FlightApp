//
//  REportServiceImp.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Sentry

class ReportServiceImp : ReportService {
    func sendError(error: Error, message: String?) {
        let nsError = error as NSError
        let exception = _createException(nsError)
        let event = _createErrorEvent(nsError, exception, message)
        SentrySDK.capture(event: event)
    }
    
    private func _createException(_ nsError: NSError) -> Exception {
        let exception = Sentry.Exception(value: "\(nsError.domain).\(nsError.code)", type: nsError.domain)
        exception.thread?.crashed = 0
        return exception
    }
    
    private func _createErrorEvent(_ nsError: NSError, _ exception: Exception, _ message: String?) -> Event {
        let event = Sentry.Event(level: .error)
        event.logger = "****.Logger"
        event.exceptions = [exception]
        event.message = message ?? ""
        event.extra = [ "error_description": nsError.description, "error_localized_description": nsError.localizedDescription ]
        return event
    }
    
    func sendEvent(message: String) {
        let event = Event(level: .info)
        event.message = message
        SentrySDK.capture(event: event)
    }
}
