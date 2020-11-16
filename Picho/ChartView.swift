//
//  ChartView.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit
import Charts

protocol ChartSeletedDelegate {
    func selectedChart(month: Int, week: Int)
    func sendDate(date: (Int, Int))
}

class ChartView: UIView, ChartViewDelegate {
    
    var viewModel: HistoryViewModel?
    var lineChartView: LineChartView!
    var timeRangeLabel: UITextField!
    var dataWeekPerMonth: [Int?: [DailyIntake]] = [:]
    var delegate: ChartSeletedDelegate?
    
    private var selectedMonth = Date().month

    func setupChartData() {
        
        let sugarEntry = (0..<dataWeekPerMonth.keys.count).map { (week) -> ChartDataEntry in
            return ChartDataEntry(
                x: Double(week),
                y: Double(dataWeekPerMonth[week + 1]?.getAverage(of: .sugar) ?? 0))
        }
        
        let sugarData = LineChartDataSet(entries: sugarEntry)
        sugarData.setColor(Color.green)
        sugarData.lineWidth = 2
        sugarData.circleRadius = 5
        sugarData.circleColors = [Color.green]
        sugarData.drawCircleHoleEnabled = false
        sugarData.drawValuesEnabled = false
        sugarData.highlightColor = Color.green
        
        let satFatEntry = (0..<dataWeekPerMonth.keys.count).map { (week) -> ChartDataEntry in
            return ChartDataEntry(
                x: Double(week),
                y: Double(dataWeekPerMonth[week + 1]?.getAverage(of: .satFat) ?? 0))
        }
        
        let satFatData = LineChartDataSet(entries: satFatEntry)
        satFatData.setColor(Color.yellow)
        satFatData.lineWidth = 2
        satFatData.circleRadius = 5
        satFatData.circleColors = [Color.yellow]
        satFatData.drawCircleHoleEnabled = false
        satFatData.drawValuesEnabled = false
        satFatData.highlightColor = Color.yellow
        
        let axisValue = (0..<dataWeekPerMonth.keys.count).map { (week) -> String in
            return "w\(week + 1)"
        }
        
        let data: LineChartData = LineChartData(dataSets: [sugarData, satFatData])
        lineChartView.data = data
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: axisValue)
        lineChartView.xAxis.axisMinimum = 0
        lineChartView.xAxis.granularity = 1
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel()
        setupChart()
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    func setupLabel() {
        timeRangeLabel = UITextField()
        timeRangeLabel.text = "\(Date().convertIntToMonth(month: Date().month)) \(Date().year)"
        timeRangeLabel.textColor = Color.green
        timeRangeLabel.layer.borderWidth = 1
        timeRangeLabel.layer.borderColor = Color.green.cgColor
        timeRangeLabel.textAlignment = .center
        timeRangeLabel.layer.cornerRadius = 8
        
        let datePicker = CustomDatePicker()
        timeRangeLabel.inputView = datePicker
        NotificationCenter.default.addObserver(self, selector: #selector(handleDate(notification:)), name: .dateChanged, object: nil)
        addSubview(timeRangeLabel)
        
        timeRangeLabel.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            heighAnchorConstant: 32, widthAnchorConstant: 140)
    }
    
    func setupChart() {
        lineChartView = LineChartView()
        lineChartView.delegate = self
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.legend.enabled = false
        addSubview(lineChartView)
        
        // Grid
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelTextColor = UIColor.secondaryLabel
        lineChartView.leftAxis.labelTextColor = UIColor.secondaryLabel
        lineChartView.xAxis.labelFont = .systemFont(ofSize: 14)

        // Label
        lineChartView.leftAxis.labelFont = .systemFont(ofSize: 14)
        lineChartView.leftAxis.gridColor = .clear
        lineChartView.leftAxis.axisMinimum = 0
        
        lineChartView.setConstraint(
            topAnchor: timeRangeLabel.bottomAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 8,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -8)
    }
    
    @objc private func handleDate(notification: Notification) {
        let data = notification.object as! (String, Int)
        
        timeRangeLabel.text = "\(data.0) \(data.1)"
        delegate?.sendDate(date: (data.0.convertIntToMonth(), data.1))
        
        selectedMonth = data.0.convertIntToMonth()
    }
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

        delegate?.selectedChart(month: selectedMonth, week: Int(entry.x))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CustomDatePicker: UIPickerView {
    
    private var months: [String] = []
    private var years: [Int] = []
    private var date: (String, Int) = ("January", 2020)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        
        months = Calendar.current.monthSymbols
        for year in 2020...2100 {
            years.append(year)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomDatePicker: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if component == 0 {
            date.0 = months[row]
        } else {
            date.1 = years[row]
        }
        
        NotificationCenter.default.post(name: .dateChanged, object: date)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return months.count
        } else {
            return years.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return months[row]
        } else {
            return String(years[row])
        }
    }
    
}

