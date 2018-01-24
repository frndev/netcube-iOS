//
//  ConsumptionChart.swift
//  netcube
//
//  Created by fran on 24/2/17.
//  Copyright © 2017 Francisco Navarro Aguilar. All rights reserved.
//


import UIKit
import Charts

public class ChartManager {
    
    func consumptionChartView(_ lineChartView: LineChartView) {
    
        lineChartView.descriptionText = ""
        
        lineChartView.drawGridBackgroundEnabled = false
        
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.rightAxis.drawLabelsEnabled = false
        lineChartView.leftAxis.labelTextColor = UIColor.white
        lineChartView.rightAxis.labelTextColor = UIColor.white
        lineChartView.xAxis.labelTextColor = UIColor.white
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.pinchZoomEnabled = false
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.scaleYEnabled = false
        lineChartView.scaleXEnabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.legend.textColor = UIColor.white
        lineChartView.gridBackgroundColor = UIColor(red: 83/255, green: 92/255, blue: 108/255, alpha: 1)
        // 4
        lineChartView.noDataText = "No data provided"
        // 5
        let months = ["Jan" , "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
        setChartData(lineChartView:lineChartView, months: months)

        
    }
    
    func setChartData(lineChartView: LineChartView,months : [String]) {
        let dollars1 = [1453.0,2352,5431,1442,5451,6486,1173,5678,9234,1345,9411,2212]
        // 1 - creating an array of data entries
        var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
        for i in 0 ..< months.count {
            yVals1.append(ChartDataEntry(x: Double(i), y: dollars1[i]))
        }
        
        // 2 - create a data set with our array
        let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "Potencia consumida")
        set1.valueTextColor = NSUIColor(red: 83/255, green: 92/255, blue: 108/255, alpha: 1)
        
        let graphColor = UIColor(red: 194/255, green: 195/255, blue: 198/255, alpha: 1)
        set1.axisDependency = .left // Line will correlate with left axis values
        
        set1.setColor(graphColor) // our line's opacity is 50%83, 92, 108
        set1.circleRadius = 0.0 // the radius of the node circle
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = graphColor
        
        set1.highlightColor = UIColor.white
        set1.drawValuesEnabled = false
        set1.drawFilledEnabled = true
        
        //3 - create an array to store our LineChartDataSets
        var dataSets : [LineChartDataSet] = [LineChartDataSet]()
        dataSets.append(set1)
        
        //4 - pass our months in for our x-axis label value along with our dataSets
        let data: LineChartData = LineChartData(dataSets: dataSets)
        
        data.setValueTextColor(UIColor.white)
        
        //5 - finally set our data
        lineChartView.data = data
    }
}
