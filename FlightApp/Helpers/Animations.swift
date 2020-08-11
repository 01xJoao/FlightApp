//
//  Animations.swift
//  FlightApp
//
//  Created by João Palma on 06/08/2020.
//  Copyright © 2020 João Palma. All rights reserved.
//

import UIKit

struct Animations {
    static func slideVerticaly(_ view: UIView, showAnimation: Bool, duration: Double = 0.35, delay: CGFloat = 0, completion: ((Bool) -> ())?) {
        let minTransform = CGAffineTransform.init(translationX: 0, y: -view.bounds.height);
        let maxTransform = CGAffineTransform.identity;
        
        view.alpha = showAnimation ? 0 : 1;
        view.transform = showAnimation ? minTransform : maxTransform
        UIView.animate(withDuration: duration, delay: TimeInterval(delay),
                       options: UIView.AnimationOptions.curveEaseOut, animations: {
                        view.alpha = showAnimation ? 1 : 0;
                        view.transform = showAnimation ? maxTransform : minTransform;
        }, completion: completion)
    }
}
