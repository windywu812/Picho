//
//  ChartView.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit
import Charts

class ChartView: UIView, ChartViewDelegate {
    
    var chartView: LineChartView!
    var timeRangeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
        setupChart()
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    func setupLabel() {
        timeRangeLabel = UILabel()
        timeRangeLabel.text = "November 2020"
        timeRangeLabel.textColor = Color.green
        timeRangeLabel.layer.borderWidth = 1
        timeRangeLabel.layer.borderColor = Color.green.cgColor
        timeRangeLabel.textAlignment = .center
        timeRangeLabel.layer.cornerRadius = 8
        addSubview(timeRangeLabel)
        
        timeRangeLabel.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            heighAnchorConstant: 32, widthAnchorConstant: 140)
    }
    
    func setupChart() {
        chartView = LineChartView()
        chartView.delegate = self
        chartView.doubleTapToZoomEnabled = false
        chartView.legend.enabled = false
        addSubview(chartView)
        
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
            topAnchor: timeRangeLabel.bottomAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 8,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -8)
        
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
        sugarData.highlightColor = Color.green
        
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
        satFatData.highlightColor = Color.yellow
        
        let data: LineChartData = LineChartData(dataSets: [sugarData, satFatData])
        chartView.data = data
        chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["1", "2", "3", "4", "5"])
        chartView.xAxis.axisMinimum = 0
        chartView.xAxis.granularity = 1
        chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
