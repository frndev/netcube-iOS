//
//  ChartDelegate.swift
//  netcube
//
//  Created by fran on 24/2/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//

import UIKit
import Charts

public class ConsumptionChartDelegate: ChartViewDelegate {
    
    let deviceViewController: DeviceViewController?
    let deviceMusicViewController: DeviceMusicViewController?
    
    init(deviceViewController: DeviceViewController) {
        self.deviceViewController = deviceViewController
        self.deviceMusicViewController = nil
    }
    
    init(deviceMusicViewController: DeviceMusicViewController) {
        self.deviceMusicViewController = deviceMusicViewController
        self.deviceViewController = nil
    }
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if let deviceController = self.deviceViewController {
            deviceController.powerLabel.text = "\(entry.y) W"
        }
        if let deviceMusicController = self.deviceMusicViewController {
            deviceMusicController.powerLabel.text = "\(entry.y) W"
        }
        
    }
    
}
