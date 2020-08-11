//
//  FindFlightsViewModel.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import Foundation

class FindFlightsViewModel : ViewModelBase {
    private let _findFlightsWebService: FindFlightsWebService
    private let _dialogService: DialogService
    
    init (findFlightsWebService : FindFlightsWebService, dialogService : DialogService) {
        _findFlightsWebService = findFlightsWebService
        _dialogService = dialogService
    }
    
    var passengersValue : String {
        get {
            return _getPassengers()
        }
    }
    
    private let _findFlight : DynamicValue<FindFlight> = DynamicValue<FindFlight>(FindFlight(FindFlightObject()))
    var findFlight : DynamicValue<FindFlight> {
        get {
            return _findFlight
        }
    }
    
    private var _airports : DynamicValueList<Airport>!
    var airports : DynamicValueList<Airport> {
        get {
            return _airports
        }
    }
    
    private var _openAirportListViewCommand: WPCommand<FlightAirportType>?
    var openAirportListViewCommand: WPCommand<FlightAirportType> {
       get {
           _openAirportListViewCommand ??= WPCommand<FlightAirportType>(_openAirportListView, canExecute: _canExecute)
           return _openAirportListViewCommand!
       }
    }
    
    private var _clearCommand: Command?
    var clearCommand: Command {
       get {
           _clearCommand ??= Command(_clearFlightData, canExecute: _canExecute)
           return _clearCommand!
       }
    }
    
    private var _swapAirportsCommand: Command?
    var swapAirportsCommand: Command {
       get {
           _swapAirportsCommand ??= Command(_swapAirports, canExecute: _canExecute)
           return _swapAirportsCommand!
       }
    }
    
    private var _setDepartureCommand : WPCommand<Date>?
    var setDepartureCommand: WPCommand<Date> {
        get {
            _setDepartureCommand ??= WPCommand<Date>(_setDeparture)
            return _setDepartureCommand!
        }
    }
    
    private var _setPassengersCommand : WPCommand<PassengersObject>?
    var setPassengersCommand: WPCommand<PassengersObject> {
        get {
            _setPassengersCommand ??= WPCommand<PassengersObject>(_setPassengers)
            return _setPassengersCommand!
        }
    }
    
    private var _submitButtonCommand : Command?
    var submitButtonCommand : Command {
        get {
            _submitButtonCommand ??= Command(_submitFindFlight, canExecute: _canExecute)
            return _submitButtonCommand!
        }
    }
    
    override func prepare(dataObject: Any) {
        _airports = (dataObject as! DynamicValueList<Airport>)
    }
    
    private func _openAirportListView(_ flightAirportType : FlightAirportType) {
        if(_canOpenAirportList(flightAirportType)) {
            let airportList = DynamicValueList<Airport>()
            airportList.addAll(object: _airports.data.value)
            
            let airportObject = AirportSearchObject(airports: airportList, market: _findFlight.value.getOriginCode(), flightAirportType: flightAirportType)
            navigationService.navigateModal(viewModel: AirportListViewModel.self, arguments: airportObject)
        }
    }
    
    private func _canOpenAirportList(_ flightAirportType : FlightAirportType) -> Bool{
        if(flightAirportType == FlightAirportType.destination && _findFlight.value.getOriginCode().isEmpty) {
            _dialogService.showInfo(selectOriginFirstLabel, informationType: .info)
            return false;
        }
        
        return true
    }
    
    private func _clearFlightData() {
        _findFlight.value.clear()
    }
    
    private func _swapAirports() {
        if(_canSwapAirports()) {
            _findFlight.value.swapAirports()
        }
    }
    
    private func _canSwapAirports() -> Bool {
        return !_findFlight.value.getDestinationCode().isEmpty
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
    
    private func _submitFindFlight() {
        if(_canFindFlight()) {
            isBusy.value = true
            
            DispatchQueue.main.async {
                _ = self._findFlightsWebService.findAvailableFlights(findFlight: self._findFlight.value, completion: self._flightsFound)
            }
        } else {
            _dialogService.showInfo(fillAllFieldsLabel, informationType: .info)
        }
    }
    
    private func _canFindFlight() -> Bool {
        if(_findFlight.value.getOriginCode().isEmpty || _findFlight.value.getDestinationCode().isEmpty) {
            return false
        }
        
        return true
    }
    
    private func _flightsFound(flights : FlightsObject?) {
        isBusy.value = false
        
        if(flights == nil || flights!.trips.isEmpty) {
            _dialogService.showInfo(noFlightsLabel, informationType: .bad)
        } else {
            navigationService.navigate(viewModel: AvailableFlightsViewModel.self, arguments: flights!, animated: true)
        }
    }
    
    override func dataNotify(dataObject: Any?) {
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
    let findFlightsTitleLabel: String = L10N.localize(key: "findflights_title")
    let departureLabel: String = L10N.localize(key: "findflights_departure")
    let passengersLabel: String = L10N.localize(key: "findflights_passengers")
    let originLabel: String = L10N.localize(key: "findflights_origin")
    let destinationLabel: String = L10N.localize(key: "findflights_destination")
    let letsGoLabel: String = L10N.localize(key: "findflights_find")
    let clearLabel: String = L10N.localize(key: "global_clear")
    let originPlaceholderCodeLabel: String = L10N.localize(key: "findflights_originCode")
    let originPlaceholderNameLabel: String = L10N.localize(key: "findflights_selectOrigin")
    let destinationPlaceholderCodeLabel: String = L10N.localize(key: "findflights_destinationCode")
    let destinationPlaceholderNameLabel: String = L10N.localize(key: "findflights_selectDestination")
    let titleDepartureLabel: String = L10N.localize(key: "findflights_originCode")
    let confirmLabel: String = L10N.localize(key: "global_confirm")
    let applyLabel: String = L10N.localize(key: "global_apply")
    let adultLabel: String = L10N.localize(key: "findflights_adult")
    let adultsLabel: String = L10N.localize(key: "findflights_adults")
    let teenLabel: String = L10N.localize(key: "findflights_teen")
    let teensLabel: String = L10N.localize(key: "findflights_teens")
    let childLabel: String = L10N.localize(key: "findflights_child")
    let childrenLabel: String = L10N.localize(key: "findflights_children")
    private let noFlightsLabel: String = L10N.localize(key: "availableflights_noflights")
    private let selectOriginFirstLabel: String = L10N.localize(key: "findflights_selectOriginFirst")
    private let fillAllFieldsLabel: String = L10N.localize(key: "findflights_fillfields")
}
