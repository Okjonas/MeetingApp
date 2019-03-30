//
//  ProfileViewController.swift
//  MeetingApp
//
//  Created by Troels on 18/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Charts

class inspectFeedbackViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    
    var iosDataEntry = PieChartDataEntry(value: 0)
    var macDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    var meetingName: String = "Test møde"
    
    var veryGoodDataEntry = PieChartDataEntry(value: 0)
    var goodDataEntry = PieChartDataEntry(value: 0)
    var mediumDataEntry = PieChartDataEntry(value: 0)
    var badDataEntry = PieChartDataEntry(value: 0)
    var veryBadDataEntry = PieChartDataEntry(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pieChart.chartDescription?.text = "Antal personer: \(25)"
        pieChart.centerText = "Feedback fra \(meetingName)"
        pieChart.animate(xAxisDuration: 0.5)
        pieChart.center = view.center
        // pieChart.centerAttributedText = CGPoint(view.center,0)
        //pieChart.centerAttributedText = true
        
        veryGoodDataEntry.value = 10
        veryGoodDataEntry.label = "Rigtig godt"
        
        goodDataEntry.value = 6
        goodDataEntry.label = "Godt"
        
        mediumDataEntry.value = 2
        mediumDataEntry.label = "Neutral"
        
        badDataEntry.value = 4
        badDataEntry.label = "Mindre godt"
        
        veryBadDataEntry.value = 2
        veryBadDataEntry.label = "Dårligt"
        
        numberOfDownloadsDataEntries = [veryGoodDataEntry, goodDataEntry, mediumDataEntry, badDataEntry, veryBadDataEntry]
        
        updateChartData()
        
    }
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(values: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
