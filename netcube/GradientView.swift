//
//  GradientView.swift
//  netcube
//
//  Created by fran on 3/4/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import QuartzCore
class GradientView: UIView {

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        //let locations: [CGFloat] = [ 0.0, 0.25, 0.5, 0.75 ]
        let locations: [CGFloat] = [ 0.0, 0.99 ]
        let startColor = UIColor(red:18/255, green: 28/255, blue: 57/255, alpha: 1)
        let endColor = UIColor(red: 75/255, green: 108/255, blue: 183/255, alpha: 1)

        let colors = [startColor.cgColor,
                      endColor.cgColor]
        
        let colorspace = CGColorSpaceCreateDeviceRGB()
        
        let gradient = CGGradient(colorsSpace: colorspace,
                                  colors: colors as CFArray, locations: locations)
        
        var startPoint = CGPoint()
        var endPoint =  CGPoint()
        
        startPoint.x = 0.0
        startPoint.y = 0.0
        endPoint.x = 0;
        endPoint.y = self.frame.size.height
        
    
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        
    }
 

}
