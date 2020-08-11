//
//  AvailableFlightsViewController.swift
//  FlightApp
//
//  Created by João Palma on 31/07/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class AvailableFlightsViewController : BaseViewController<AvailableFlightsViewModel> {
    private let _searchController = CustomSearchController()
    private let _tableView = UITableView()
    private let _topView = UIView(backgroundColor: UIColor.Theme.mainBlue)
    private lazy var _dataSourceProvider = AvailableFlightsDataSource(tableView: _tableView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.titleLabel
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        _setupView()
    }
    
    private func _setupView() {
        _configureTopbar()
        _configureTableView()
    }
    
    private func _configureTopbar() {
        _configureNavigationBar()
        let topPadding = Utils.keyWindow.safeAreaInsets.top + 44
        _topView.withHeight(topPadding + 85)
        self.view.addSubview(_topView)
        _topView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: self.view.trailingAnchor)
        
        let airportDetailOrigin = _createAirportDetail(name: viewModel.flights.getOriginName(), code: viewModel.flights.getOriginCode(), .left)
        
        _topView.addSubview(airportDetailOrigin)
        airportDetailOrigin.anchor(top: _topView.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil,
            padding: .init(top: topPadding + 15, left: 23, bottom: 0, right: 20))
        
        let airportDetailDestination = _createAirportDetail(name: viewModel.flights.getDestinationName(), code: viewModel.flights.getDestinationCode(), .right)
        
        _topView.addSubview(airportDetailDestination)
        airportDetailDestination.anchor(top: _topView.topAnchor, leading: nil, bottom: nil, trailing: self.view.safeAreaLayoutGuide.trailingAnchor,
                             padding: .init(top: topPadding + 15, left: 20, bottom: 0, right: 23))
        
        let calendar = _createCalendar()
        
        _topView.addSubview(calendar)
        calendar.anchor(top: _topView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: topPadding + 20, left: 0, bottom: 0, right: 0))
        calendar.centerXTo(_topView.centerXAnchor)
        
        let createDashView = _createDash()
        _topView.addSubview(createDashView)
        createDashView.anchor(top: nil, leading: calendar.leadingAnchor, bottom: _topView.bottomAnchor,
                              trailing: calendar.trailingAnchor, padding: .init(top: 0, left: -25, bottom: 32, right: -25))
    }
    
    private func _createAirportDetail(name : String, code : String, _ align : NSTextAlignment) -> UIView {
        let nameLabel = UILabel(text: name, font: .systemFont(ofSize: 11, weight: .semibold), textColor: UIColor.Theme.white, textAlignment: align, numberOfLines: 1)
        let codeLabel = UILabel(text: code, font: .systemFont(ofSize: 33, weight: .bold), textColor: UIColor.Theme.gold, textAlignment: align, numberOfLines: 1)
        
        let stack = UIView().stack(
            nameLabel,
            codeLabel
        )
        
        return stack
    }
    
    private func _createCalendar() -> UIView {
        let calendarImage = changeImageColor("Calendar", UIColor.Theme.gold)
        let calendarLabel = UILabel.init(text: viewModel.flights.getDeparture(), font: .systemFont(ofSize: 12, weight: .bold),
                                         textColor: UIColor.Theme.white, textAlignment: .center, numberOfLines: 1)
        
        let calendarStack = UIView().hstack(
            calendarImage,
            calendarLabel,
            spacing: 8
        )

        return calendarStack
    }
    
    private func _createDash() -> UIView {
        let dashedLine = createDashedLine()
        let circle1 = createCircle()
        let circle2 = createCircle()
        
        dashedLine.addSubview(circle1)
        circle1.anchor(top: nil, leading: dashedLine.leadingAnchor, bottom: nil, trailing: nil)
        dashedLine.addSubview(circle2)
        circle1.centerYTo(dashedLine.centerYAnchor)
        circle2.anchor(top: nil, leading: nil, bottom: nil, trailing: dashedLine.trailingAnchor)
        circle2.centerYTo(dashedLine.centerYAnchor)
        
        return dashedLine
    }
    
    private func _configureNavigationBar() {
        let navBarAppearance = AppConfiguration.customNavbarAppearence()
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func _configureTableView() {
        if(viewModel.flights.getFlights().isEmpty) {
            let noFlightsLabel = UILabel(text: viewModel.noAvailableFlightsLabel, font: .boldSystemFont(ofSize: 13), textColor: UIColor.Theme.darkGrey, textAlignment: .center)
            self.view.addSubview(noFlightsLabel)
            noFlightsLabel.centerXTo(self.view.centerXAnchor)
            noFlightsLabel.centerYTo(self.view.centerYAnchor)
        } else {
            self.view.addSubview(_tableView)
            
            _tableView.translatesAutoresizingMaskIntoConstraints = false
            _tableView.anchor(top: _topView.bottomAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor,
                              bottom: self.view.bottomAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor)

            _tableView.dataSource = _dataSourceProvider
            _tableView.delegate = _dataSourceProvider
            
            
            _dataSourceProvider.labels = [
                viewModel.departLabel,
                viewModel.arriveLabel,
                viewModel.flightNrLabel,
                viewModel.soldOutLabel,
                viewModel.hrsLabel
            ]
            
            _dataSourceProvider.flights = viewModel.flights.getFlights()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        _tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (self.isMovingToParent)
        {
            if (navigationController?.visibleViewController is ContainerViewController) {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
            }
        }
    }
}
