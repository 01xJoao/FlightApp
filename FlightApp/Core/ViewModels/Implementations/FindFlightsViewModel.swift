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
    
    public override func dataNotify(dataObject: Any?) {
        let airportSearch = dataObject as! AirportSearchObject
        _manageAirportSelected(airportSearch)
    }
    
    private func _manageAirportSelected(_ airportSearch : AirportSearchObject) {
        if(airportSearch.market!.isEmpty){
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
}
