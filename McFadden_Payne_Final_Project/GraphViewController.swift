/*  Name: Luke McFadden, Adam Payne
 *  Assignment: Final Project
 *  Documentation Stmt: None
 */

import Foundation
import UIKit
import Charts

class GraphViewController: UIViewController {
    
    
    @IBOutlet weak var BarChartView: BarChartView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var todo: ToDo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo {
            navigationItem.title = "Graph"
            titleLabel.text = todo.title
        }
        else {
        }
        setChartValues()
        assignBackground()
        
    }
    
    func assignBackground(){
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "graphPaperGreen")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
    
    
    
    func setChartValues(_ count: Int = 20) {
        var barChartValues: [BarChartDataEntry] = []
        
        
        let dataEntry1 = BarChartDataEntry(x: 2, y: Double(todo?.amount ?? 0))
        let dataEntry2 = BarChartDataEntry(x: 4, y: 1)
        let dataEntry3 = BarChartDataEntry(x: 6, y: 3)
        let dataEntry4 = BarChartDataEntry(x: 8, y: 7)
        let dataEntry5 = BarChartDataEntry(x: 14, y: 3)
        barChartValues.append(dataEntry1)
        barChartValues.append(dataEntry2)
        barChartValues.append(dataEntry3)
        barChartValues.append(dataEntry4)
        barChartValues.append(dataEntry5)
        
        let chartDataSet = BarChartDataSet(entries: barChartValues, label: todo?.title)
        var dataSets = [IChartDataSet]()
        dataSets.append(chartDataSet)
        
        let chartData = BarChartData(dataSets: dataSets)
        self.BarChartView.data = chartData
        self.BarChartView.chartDescription?.text = ""
        
        self.BarChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
    }
    
}
