//
//  PerQustionViewController.swift
//  MeetingApp
//
//  Created by Troels on 22/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Charts

class PerQustionViewController: UIViewController {

    @IBOutlet weak var barView: BarChartView!
    // burde være per spøgrsmål
    var veryGoodDataEntry = BarChartDataEntry()
    var goodDataEntry = BarChartDataEntry()
    var mediumDataEntry = BarChartDataEntry()
    var badDataEntry = BarChartDataEntry()
    var veryBadDataEntry = BarChartDataEntry()
    
    var numberOfDownloadsDataEntries = [BarChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // barView.chartDescription?.text = "Antal personer: \(25)"
       // barView.animate(xAxisDuration: 0.5)
        //barView.center = view.center
     //   barView.debugDescription = "debug bar"
      //  barView
        
        barView.animate(xAxisDuration: 0.5)
       // barView.drawBarShadowEnabled = true
        barView.drawMarkers = false
        barView.drawGridBackgroundEnabled = true
        barView.drawMarkers = false
        barView.gridBackgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        veryGoodDataEntry.x = 0
        veryGoodDataEntry.yValues = [2,3,4,5,1]
        
        goodDataEntry.x = 1
        goodDataEntry.yValues = [2,3,6,2,0]
        
        mediumDataEntry.x = 2
        mediumDataEntry.yValues = [1,2,3,4,5]
        
        badDataEntry.x = 3
        badDataEntry.yValues = [2,2,2,2,2]
        veryBadDataEntry.x = 4
        veryBadDataEntry.yValues = [1,1,1,1,1]
        
        numberOfDownloadsDataEntries = [veryGoodDataEntry,goodDataEntry, mediumDataEntry, badDataEntry, veryBadDataEntry]
        
        updateChartData()
    }
    

    func updateChartData() {
        
        let chartDataSet = BarChartDataSet(values: numberOfDownloadsDataEntries, label: "spørgsmål data")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        let colors = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]
        chartDataSet.colors = colors as! [NSUIColor]
        
        barView.data = chartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }

}
