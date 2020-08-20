//
//  NavigationService.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

protocol NavigationService {
    func containerViewController() -> ContainerViewController
    func navigate<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?, animated: Bool)
    func navigateModal<TViewModel : ViewModel>(viewModel: TViewModel.Type, arguments: Any?)
    func navigateAndSetAsContainer<TViewModel : ViewModel>(viewModel: TViewModel.Type)
    func close(arguments: Any?, animated: Bool)
    func closeModal(arguments: Any?)
}
