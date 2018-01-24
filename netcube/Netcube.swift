//
//  Netcube.swift
//  netcube
//
//  Created by fran on 26/2/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

let primaryColor = UIColor(red: 1/255, green: 15/255, blue: 51/255, alpha: 1)
let separatorCellColor = UIColor(red: 245/255, green: 245/255, blue: 250/255, alpha: 1)

func gradientColor(_ view: UIView) {
    let gradient = CAGradientLayer()
    
    let startColor = UIColor(red: 18/255, green: 28/255, blue: 57/255, alpha: 1)
    let endColor = UIColor(red: 57/255, green: 84/255, blue: 171/255, alpha: 1)
    
    gradient.frame = view.bounds
    gradient.colors = [startColor.cgColor, endColor.cgColor]
    
    var startPoint = CGPoint()
    var endPoint =  CGPoint()
    
    startPoint.x = 0.0
    startPoint.y = 0.0
    endPoint.x = 0;
    endPoint.y = view.frame.size.height
    
    gradient.startPoint = startPoint
    gradient.endPoint = endPoint
    
    view.layer.insertSublayer(gradient, at: 0)
}
