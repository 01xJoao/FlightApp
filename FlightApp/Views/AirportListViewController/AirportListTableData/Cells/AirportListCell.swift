//
//  AirportListCell.swift
//  FlightApp
//
//  Created by João Palma on 05/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import Foundation

class AirportListCell: UITableViewCell {
    public func config(_ airport : Airport) {
        self.removeAllSubViews()
        
        let airportLabel = UILabel.init(text: airport.getName(), font: .systemFont(ofSize: 16, weight: .semibold), textColor: UIColor.Theme.black , textAlignment: .left, numberOfLines: 0)
        let countryLabel = UILabel.init(text: airport.getCountryName(), font: .systemFont(ofSize: 14), textColor: UIColor.Theme.black, textAlignment: .left, numberOfLines: 0)

        let labelStack = UIView().stack(
            airportLabel,
            countryLabel,
            spacing: 4
        )
        
        let codeLabel = UILabel.init(text: airport.getCode(), font: .systemFont(ofSize: 18, weight: .semibold), textColor: UIColor.Theme.mainBlue, textAlignment: .right, numberOfLines: 0)
        
        self.hstack(
            labelStack,
            UIView(),
            codeLabel,
            spacing: 0,
            alignment: .center
        ).padLeft(35).padRight(35)
        
        let separatorLine = UIView()
        separatorLine.constrainHeight(1)
        separatorLine.backgroundColor = UIColor.Theme.grey
        
        self.addSubview(separatorLine)
        separatorLine.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 35, bottom: 0, right: 35))
    }
}
