//
//  ButterflyGradient.swift
//  GreenButterflyFirebase
//
//  Created by Jordan Furr on 5/21/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//
import UIKit
import Foundation

class ButterflyGradient: UIView {
   static func setUpButterflyView(view: UIView){
        let image = UIImage(named: "net")!
        let mask = CALayer()
        mask.contents = image.cgImage
        mask.frame.size = image.size
        let gradient = CAGradientLayer()
        gradient.frame.size = image.size
        
        gradient.colors = [
            UIColor(red: 0.04, green: 0.13, blue: 0.59, alpha: 1).cgColor,
            UIColor(red: 0.08, green: 1, blue: 0.3, alpha: 1).cgColor,
            UIColor(red: 0.85, green: 0.25, blue: 0.25, alpha: 1).cgColor
        ]
        gradient.mask = mask
    gradient.frame.origin = CGPoint(x: (view.center.x), y: (view.center.y))
        view.layer.addSublayer(gradient)
    }
}
