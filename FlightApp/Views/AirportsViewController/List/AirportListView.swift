//
//  AirportListView.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import LBTATools

class AirportListView : LBTAListController<AirportCell, UIColor>, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        _setupView()
    }
    
    private func _setupView() {
        items = [
            UIColor.Theme.grey, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue,
            UIColor.Theme.grey, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue,
            UIColor.Theme.grey, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue,
            UIColor.Theme.grey, UIColor.Theme.mainBlue, UIColor.Theme.darkBlue
        ]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewlayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 100)
    }
}
