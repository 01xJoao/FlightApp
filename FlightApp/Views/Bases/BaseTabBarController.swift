//
//  BaseTabBarController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class BaseTabBarController<TViewModel : ViewModel> : UITabBarController {
    private var _viewModel: TViewModel!
    var viewModel: TViewModel {
        get {
            return _viewModel
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _instantiateViewModel()
    }
    
    private func _instantiateViewModel() {
        let vm : TViewModel = DiContainer.resolve()
        _viewModel = vm
        _viewModel.initialize()
    }
}

