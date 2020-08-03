//
//  ViewModelBase.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

public class ViewModelBase : ViewModel {
    private let _navigationService: NavigationService = DiContainer.resolve()
    private let _reportService: ReportService = DiContainer.resolve()
    
    public let isBusy : DynamicValue<Bool> = DynamicValue<Bool>(false)
    
    public var navigationService: NavigationService {
        get { return _navigationService }
    }
    
    public var reportService: ReportService {
        get { return _reportService }
    }
    
    public func prepare(dataObject: Any) {}
    public func initialize() {}
    public func appearing() {}
    public func disappearing() {}
    public func backAction() {}
    public func dataNotify(dataObject: Any?) {}
}

public class ViewModelBaseWithArguments<TObject> : ViewModelBase {
    public override func prepare(dataObject: Any) {
        prepare(data: dataObject as! TObject)
    }
    
    public func prepare(data: TObject) {}
}
