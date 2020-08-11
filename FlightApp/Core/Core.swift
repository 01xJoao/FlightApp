//
//  Core.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

struct Core {
    static func initialize() {
        _registerServices()
        _registerViewModels()
        _registerViewControllers()
    }
    
    private static func _registerServices() {
        DiContainer.registerSingleton(NavigationService.self) { NavigationServiceImp() }
        DiContainer.registerSingleton(DialogService.self) { DialogServiceImp() }
        DiContainer.registerSingleton(ReportService.self) { ReportServiceImp() }
        DiContainer.registerSingleton(WebService.self) { WebServiceImp(reportService: DiContainer.resolve()) }
        DiContainer.registerSingleton(AirportWebService.self) { AirportWebServiceImp(webService: DiContainer.resolve()) }
        DiContainer.registerSingleton(FindFlightsWebService.self) { FindFlightsWebServiceImp(webService: DiContainer.resolve()) }
    }
    
    private static func _registerViewModels() {
        DiContainer.register(MainViewModel.self, constructor: { MainViewModel(airportWebService: DiContainer.resolve()) })
        DiContainer.register(AirportsViewModel.self, constructor: { AirportsViewModel() })
        DiContainer.register(FindFlightsViewModel.self, constructor: { FindFlightsViewModel(findFlightsWebService: DiContainer.resolve(), dialogService: DiContainer.resolve()) })
        DiContainer.register(AvailableFlightsViewModel.self, constructor: { AvailableFlightsViewModel() })
        DiContainer.register(AirportListViewModel.self, constructor: { AirportListViewModel() })
    }
    
    private static func _registerViewControllers() {
        DiContainer.registerViewController(MainViewModel.self, constructor: { MainViewController() })
        DiContainer.registerViewController(AirportsViewModel.self, constructor: { AirportsViewController() })
        DiContainer.registerViewController(FindFlightsViewModel.self, constructor: { FindFlightsViewController() })
        DiContainer.registerViewController(AvailableFlightsViewModel.self, constructor: { AvailableFlightsViewController() })
        DiContainer.registerViewController(AirportListViewModel.self, constructor: { AirportListViewController() })
    }
    
    static func startApp() {
        let navigationService : NavigationService = DiContainer.resolve()
        navigationService.navigateAndSetAsContainer(viewModel: MainViewModel.self)
    }
}
