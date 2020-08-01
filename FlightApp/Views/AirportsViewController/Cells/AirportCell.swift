//
//  AirportCell.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import LBTATools

class AirportCell: LBTAListCell<UIColor> {
    public override var item: UIColor! {
        didSet {
            backgroundColor = item
        }
    }
}
