//
//  Core.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

public struct Core {
    public static func initialize() {
        _registerServices()
        _registerViewModels()
        _registerViewControllers()
    }
    
    private static func _registerServices() {
        DiContainer.registerSingleton(NavigationService.self) { NavigationServiceImp() }
        //DiContainer.registerSingleton(DialogService.self) { DialogServiceImp(navigationService: DiContainer.resolve()) }
        //DiContainer.registerSingleton(ReportService.self) { ReportServiceImp() }
        //DiContainer.registerAsSingleton(AppSettingsService.self) { AppSettingsServiceImp() }
        //DiContainer.registerAsSingleton(DatabaseUserService.self) { DatabaseUserServiceImp(reportService: DiContainer.resolve()) }
        //DiContainer.registerAsSingleton(WebService.self) { WebServiceImp(reportService: DiContainer.resolve()) }
        //DiContainer.registerAsSingleton(UserWebService.self) { UserWebServiceImp(webService: DiContainer.resolve()) }
    }
    
    private static func _registerViewModels() {
        DiContainer.register(MainViewModel.self, constructor: { MainViewModel() })
        DiContainer.register(AirportsViewModel.self, constructor: { AirportsViewModel() })
        DiContainer.register(FindFlightsViewModel.self, constructor: { FindFlightsViewModel() })
        DiContainer.register(AvailableFlightsViewModel.self, constructor: { AvailableFlightsViewModel() })
    }
    
    private static func _registerViewControllers() {
        DiContainer.registerViewController(MainViewModel.self, constructor: { MainViewController() })
        DiContainer.registerViewController(AirportsViewModel.self, constructor: { AirportsViewController() })
        DiContainer.registerViewController(FindFlightsViewModel.self, constructor: { FindFlightsViewController() })
        DiContainer.registerViewController(AvailableFlightsViewModel.self, constructor: { AvailableFlightsViewController() })
    }
    
    public static func startApp() {
        let navigationService : NavigationService = DiContainer.resolve()
        navigationService.navigateAndSetAsContainer(viewModel: MainViewModel.self)
    }
}
