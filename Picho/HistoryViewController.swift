//
//  ProgressViewController.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit
import Charts

class HistoryViewController: UIViewController, ChartViewDelegate {
    
    private var chartView: LineChartView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupChart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChart()
        navigationItem.title = "Progress"
    }
    
    private func setupChart() {
        chartView = LineChartView()
        chartView.delegate = self
        chartView.doubleTapToZoomEnabled = false
        chartView.backgroundColor = .white
        chartView.legend.enabled = false
        view.addSubview(chartView)
        
        // Grid
        chartView.rightAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelTextColor = UIColor.secondaryLabel
        chartView.leftAxis.labelTextColor = UIColor.secondaryLabel
        chartView.xAxis.labelFont = .systemFont(ofSize: 14)

        // Label
        chartView.leftAxis.labelFont = .systemFont(ofSize: 14)
        chartView.leftAxis.gridColor = .clear
        chartView.leftAxis.axisMinimum = 0
        
        chartView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 336)
        
        let sugarEntry = (0..<5).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(Int.random(in: 100...500)))
        }
        
        let sugarData = LineChartDataSet(entries: sugarEntry)
        sugarData.setColor(Color.green)
        sugarData.lineWidth = 2
        sugarData.circleRadius = 5
        sugarData.circleColors = [Color.green]
        sugarData.drawCircleHoleEnabled = false
        sugarData.drawValuesEnabled = false
        
        let satFatEntry = (0..<5).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: Double(Int.random(in: 100...500)))
        }
        
        let satFatData = LineChartDataSet(entries: satFatEntry)
        satFatData.setColor(Color.yellow)
        satFatData.lineWidth = 2
        satFatData.circleRadius = 5
        satFatData.circleColors = [Color.yellow]
        satFatData.drawCircleHoleEnabled = false
        satFatData.drawValuesEnabled = false
        
        let data: LineChartData = LineChartData(dataSets: [sugarData, satFatData])
        chartView.data = data
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["1", "2", "3", "4", "5"])
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.granularity = 1
        chartView.animate(xAxisDuration: 2.5, yAxisDuration: 2.5, easingOption: .linear)
    }
    
}

