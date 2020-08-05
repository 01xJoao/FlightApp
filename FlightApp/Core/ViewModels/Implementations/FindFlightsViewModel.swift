//
//  FindFlightsViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

public class FindFlightsViewModel : ViewModelBase {
    private let _findFlight : DynamicValue<FindFlight> = DynamicValue<FindFlight>(FindFlight(FindFlightObject()))
    public var findFlight : DynamicValue<FindFlight> {
        get {
            return _findFlight
        }
    }
    
    private var _airports : DynamicValueList<Airport>?
    public var airports : DynamicValueList<Airport> {
        get {
            return _airports!
        }
    }
    
    private var _openAirportListViewCommand: WPCommand<FlightAirportType>?
    public var openAirportListViewCommand: WPCommand<FlightAirportType> {
       get {
           _openAirportListViewCommand ??= WPCommand<FlightAirportType>(_openAirportListView, canExecute: _canExecute)
           return _openAirportListViewCommand!
       }
    }
    
    public override func prepare(dataObject: Any) {
        _airports = (dataObject as! DynamicValueList<Airport>)
    }
    
    private func _openAirportListView(_ flightAirportType : FlightAirportType) {
        let airportObject = AirportSearchObject(airports: airports, market: _findFlight.value.getOriginCode(), flightAirportType: flightAirportType)
        navigationService.navigateModal(viewModel: AirportListViewModel.self, arguments: airportObject)
    }
    
    private func _canExecute() -> Bool {
        return !isBusy.value
    }
    
    //L10N Strings
    public let findFlightsTitleLabel: String = L10N.localize(key: "findflights_title")
    public let departureLabel: String = L10N.localize(key: "findflights_departure")
    public let passengersLabel: String = L10N.localize(key: "findflights_passengers")
    public let originLabel: String = L10N.localize(key: "findflights_origin")
    public let destinationLabel: String = L10N.localize(key: "findflights_destination")
    public let letsGoLabel: String = L10N.localize(key: "findflights_find")
    public let clearLabel: String = L10N.localize(key: "global_clear")
}
