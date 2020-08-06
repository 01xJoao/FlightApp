//
//  FindFlightsViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

public class FindFlightsViewModel : ViewModelBase {
    public var passengersValue : String {
        get {
            return _getPassengers()
        }
    }
    
    private let _findFlight : DynamicValue<FindFlight> = DynamicValue<FindFlight>(FindFlight(FindFlightObject()))
    public var findFlight : DynamicValue<FindFlight> {
        get {
            return _findFlight
        }
    }
    
    private var _airports : DynamicValueList<Airport>!
    public var airports : DynamicValueList<Airport> {
        get {
            return _airports
        }
    }
    
    private var _openAirportListViewCommand: WPCommand<FlightAirportType>?
    public var openAirportListViewCommand: WPCommand<FlightAirportType> {
       get {
           _openAirportListViewCommand ??= WPCommand<FlightAirportType>(_openAirportListView, canExecute: _canExecute)
           return _openAirportListViewCommand!
       }
    }
    
    private var _clearCommand: Command?
    public var clearCommand: Command {
       get {
           _clearCommand ??= Command(_clearFlightData, canExecute: _canExecute)
           return _clearCommand!
       }
    }
    
    private var _swapAirportsCommand: Command?
    public var swapAirportsCommand: Command {
       get {
           _swapAirportsCommand ??= Command(_swapAirports, canExecute: _canExecute)
           return _swapAirportsCommand!
       }
    }
    
    private var _setDepartureCommand : WPCommand<Date>?
    public var setDepartureCommand: WPCommand<Date> {
        get {
            _setDepartureCommand ??= WPCommand<Date>(_setDeparture)
            return _setDepartureCommand!
        }
    }
    
    private var _setPassengersCommand : WPCommand<PassengersObject>?
    public var setPassengersCommand: WPCommand<PassengersObject> {
        get {
            _setPassengersCommand ??= WPCommand<PassengersObject>(_setPassengers)
            return _setPassengersCommand!
        }
    }
    
    public override func prepare(dataObject: Any) {
        _airports = (dataObject as! DynamicValueList<Airport>)
    }
    
    private func _openAirportListView(_ flightAirportType : FlightAirportType) {
        let airportList = DynamicValueList<Airport>()
        airportList.addAll(object: _airports.data.value)
        
        let airportObject = AirportSearchObject(airports: airportList, market: _findFlight.value.getOriginCode(), flightAirportType: flightAirportType)
        navigationService.navigateModal(viewModel: AirportListViewModel.self, arguments: airportObject)
    }
    
    private func _clearFlightData() {
        _findFlight.value.clear()
    }
    
    private func _swapAirports() {
        _findFlight.value.swapAirports()
    }
    
    private func _setDeparture(date : Date) {
        _findFlight.value.setDeparture(date)
    }
    
    private func _setPassengers(passengers : PassengersObject) {
        _findFlight.value.setPassengers(passengers)
    }
    
    private func _getPassengers() -> String {
        var passengers = ""
        
        let getPassengers = _findFlight.value.getPassengers()
        
        if(getPassengers.adults > 0) {
            passengers += "\(getPassengers.adults) \(getPassengers.adults > 1 ? adultsLabel : adultLabel)"
        }
        
        if(getPassengers.teen > 0) {
            passengers += passengers.isEmpty ? "" : ", "
            passengers += "\(getPassengers.teen) \(getPassengers.teen > 1 ? teensLabel : teenLabel)"
        }
        
        if(getPassengers.children > 0) {
            passengers += passengers.isEmpty ? "" : ", "
            passengers += "\(getPassengers.children) \(getPassengers.children > 1 ? childrenLabel : childLabel)"
        }
        
        return passengers
    }
    
    public override func dataNotify(dataObject: Any?) {
        let airportSearch = dataObject as! AirportSearchObject
        _manageAirportSelected(airportSearch)
    }
    
    private func _manageAirportSelected(_ airportSearch : AirportSearchObject) {
        if(airportSearch.market!.isEmpty) {
            return
        }
        
        let airport = airports.data.value.first(where: { $0.getCode() == airportSearch.market })!
        
        if(airportSearch.flightAirportType == .origin) {
            _findFlight.value.setOrigin(originName: airport.getName(), originCode: airport.getCode())
            
            if(!_findFlight.value.getDestinationCode().isEmpty) {
                let airportDestination = airports.data.value.first(where: { $0.getCode() == _findFlight.value.getDestinationCode() })!
                
                if(!airportDestination.containsMarket(airportSearch.market!)) {
                     _findFlight.value.clearDestination()
                 }
            }
        } else {
            _findFlight.value.setDestination(destinationName: airport.getName(), destinationCode: airport.getCode())
        }
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
    public let originPlaceholderCodeLabel: String = L10N.localize(key: "findflights_originCode")
    public let originPlaceholderNameLabel: String = L10N.localize(key: "findflights_selectOrigin")
    public let destinationPlaceholderCodeLabel: String = L10N.localize(key: "findflights_destinationCode")
    public let destinationPlaceholderNameLabel: String = L10N.localize(key: "findflights_selectDestination")
    public let titleDepartureLabel: String = L10N.localize(key: "findflights_originCode")
    public let confirmLabel: String = L10N.localize(key: "global_confirm")
    public let applyLabel: String = L10N.localize(key: "global_apply")
    public let adultLabel: String = L10N.localize(key: "findflights_adult")
    public let adultsLabel: String = L10N.localize(key: "findflights_adults")
    public let teenLabel: String = L10N.localize(key: "findflights_teen")
    public let teensLabel: String = L10N.localize(key: "findflights_teens")
    public let childLabel: String = L10N.localize(key: "findflights_child")
    public let childrenLabel: String = L10N.localize(key: "findflights_children")
}
