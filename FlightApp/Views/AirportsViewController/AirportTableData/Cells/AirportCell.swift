//
//  AirportCell.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit
import ImageLoader

class AirportCell: UITableViewCell {
    let mainView = UIView()
    
    public func config(_ airport : Airport) {
        self.removeAllSubViews()
        
        let shadowView = ShadowView(cornerRadius: 5)
        
        self.addSubview(shadowView)
        shadowView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))

        let mainView = UIView()
        mainView.layer.cornerRadius = 5
        mainView.layer.masksToBounds = true;
        
        self.addSubview(mainView)
        mainView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 5, left: 10, bottom: 5, right: 10))

        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        
        if(airport.getImageUrl() != nil) {
            ImageLoader.request(with: airport.getImageUrl()!, onCompletion: { image ,_ ,_ in
                DispatchQueue.main.async {
                    backgroundImage.image = image
                }
            })
        }

        mainView.addSubview(backgroundImage)
        backgroundImage.anchor(top: mainView.topAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor)
        
        let title = UILabel.init(text: airport.getName(), font: .systemFont(ofSize: 30, weight: .bold), textColor: UIColor.Theme.white, textAlignment: .left, numberOfLines: 0)
        title.setupShadow(opacity: 0.65, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)
        
        let subtitle = UILabel.init(text: airport.getCode(), font: .systemFont(ofSize: 21, weight: .bold), textColor: UIColor.Theme.white, textAlignment: .left, numberOfLines: 0)
        subtitle.setupShadow(opacity: 0.8, radius: 2, offset: CGSize(width: 0.5, height: 0.5), color: UIColor.Theme.black)

        mainView.stack(
            title,
            subtitle,
            UIView(),
            spacing: 2,
            alignment: .top
        ).padLeft(5)
        
        let deformSquare = DeformSquare()
        deformSquare.constrainHeight(50)

        mainView.addSubview(deformSquare)
        deformSquare.anchor(top: nil, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor)


        let latitudeLabel = UILabel.init(text: airport.getLatitude(), font: .systemFont(ofSize: 9, weight: .semibold), textColor: UIColor.Theme.black , textAlignment: .right, numberOfLines: 0)
        let longitudeLabel = UILabel.init(text: airport.getLongitude(), font: .systemFont(ofSize: 9, weight: .semibold), textColor: UIColor.Theme.black, textAlignment: .right, numberOfLines: 0)

        let locationImage = getImageInBlue("Location")
        locationImage.withHeight(25).withWidth(25)
        locationImage.setupShadow(opacity: 0.5, radius: 1, offset: CGSize(width: 1, height: 1), color: UIColor.Theme.black)

        deformSquare.hstack(
            UIView(),
            locationImage,
            stack(
                latitudeLabel,
                longitudeLabel,
                spacing: 1),
            spacing: 4,
            alignment: .bottom
        ).padRight(10).padBottom(10)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
      }

      required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
}
