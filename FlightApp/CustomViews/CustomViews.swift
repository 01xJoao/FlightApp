//
//  CustomViews.swift
//  FlightApp
//
//  Created by João Palma on 01/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

class DeformSquare : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        
        let p1 = CGPoint(x: 0, y: size.height)
        let p2 = CGPoint(x: p1.x + size.width, y: p1.y)
        let p3 = CGPoint(x: p2.x, y: 0)
        let p4 = CGPoint(x: 0, y: size.height)
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.close()

        UIColor.Theme.white.set()
        path.fill()
    }
}

func createActivityIndicatory(view : UIView) -> UIActivityIndicatorView {
    let activityView = UIActivityIndicatorView(style: .large)
    activityView.center = view.center
    view.addSubview(activityView)
    
    return activityView
}

func backgroundRoundBorderView(color : UIColor = UIColor.Theme.darkerWhite, radius : CGFloat = 8) -> UIView {
    let backgrounView = UIView()
    backgrounView.backgroundColor = color
    backgrounView.layer.cornerRadius = radius
    backgrounView.layer.masksToBounds = true;
    
    return backgrounView
}

func getImageInBlue(_ imageName : String) -> UIImageView {
    let imageView = UIImageView(image: UIImage(named: imageName), contentMode: .scaleAspectFit)
    imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
    imageView.tintColor = UIColor.Theme.mainBlue
    
    return imageView
}

func createMainBlueButton(name : String, target : Any, action : Selector) -> UIButton {
    let button = UIButton(title: name, titleColor: UIColor.Theme.darkBlue, font: .boldSystemFont(ofSize: 20),
                          backgroundColor: UIColor.Theme.babyBlue, target: target, action: action)
    
    button.layer.cornerRadius = 6
    button.layer.masksToBounds = true;
    button.constrainHeight(52)
    
    return button
}
