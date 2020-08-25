//
//  ViewModelBase.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

class ViewModelBase : ViewModel {
    private(set) var navigationService: NavigationService = DiContainer.resolve()
    let isBusy : DynamicValue<Bool> = DynamicValue<Bool>(false)
    
    func prepare(dataObject: Any) {}
    func initialize() {}
    func appearing() {}
    func disappearing() {}
    func backAction() {}
    func dataNotify(dataObject: Any?) {}
}

//class ViewModelBaseWithArguments<TObject> : ViewModelBase {
//    override func prepare(dataObject: Any) {
//        prepare(data: dataObject as! TObject)
//    }
//
//    func prepare(data: TObject) {}
//}
