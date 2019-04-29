//
//  GraphViewController.swift
//  McFadden_Payne_Final Project
//
//  Created by Luke McFadden on 4/28/19.
//  Copyright © 2019 Adam Payne. All rights reserved.
//

import Foundation
import UIKit
import Charts

class GraphViewController: UIViewController {
    
    @IBOutlet weak var LineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChartValues()
        
    }
    
    func setChartValues(_ count: Int = 20) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count)) + 3)
            return ChartDataEntry(x: Double(i), y:val)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "DataSet 1")
        let data = LineChartData(dataSet: set1)
        
        self.LineChartView.data = data
    }
    
}
