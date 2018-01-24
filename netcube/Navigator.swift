//
//  Navigator.swift
//  netcube
//
//  Created by fran on 26/2/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit

struct Navigator {
    
    static func moveToDeviceViewControllerWith(_ device: [String:String], navigationController nav: UINavigationController,indexPath i:IndexPath) {
        
        switch i.row {
        case 4:
            let vc = DeviceMusicViewController(device: device)
            
            nav.pushViewController(vc, animated: true)
        default:
            let vc = DeviceViewController(device: device)
            
            nav.pushViewController(vc, animated: true)
        }
        
       
        
    }
    
}
