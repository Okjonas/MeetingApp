//
//  ProfileViewController.swift
//  MeetingApp
//
//  Created by Troels on 18/03/2019.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit
import Charts

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    
    var iosDataEntry = PieChartDataEntry(value: 0)
    var macDataEntry = PieChartDataEntry(value: 0)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       pieChart.chartDescription?.text = ""
        
        iosDataEntry.value = 2
        iosDataEntry.label = "iOS"
        
        macDataEntry.value = 4
        macDataEntry.label = "macOS"
        
        numberOfDownloadsDataEntries = [iosDataEntry, macDataEntry]
        
        updateChartData()
        
    }
    
    @IBAction func changeiOS(_ sender: UIStepper) {
        iosDataEntry.value = sender.value
        updateChartData()
    }
    
    @IBAction func changeMac(_ sender: UIStepper) {
        macDataEntry.value = sender.value
        updateChartData()
    }
    
    
    func updateChartData() {
        
        let chartDataSet = PieChartDataSet(values: numberOfDownloadsDataEntries, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)]
        chartDataSet.colors = colors as! [NSUIColor]
        
        pieChart.data = chartData
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
