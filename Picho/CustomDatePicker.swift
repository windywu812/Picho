//
//  CustomDatePicker.swift
//  Picho
//
//  Created by Windy on 25/11/20.
//

import UIKit

class CustomDatePicker: UIPickerView {
    
    private var historyPerYear: [Int: [DailyIntake]] = [:]
    private var date: (String, Int) = ("January", 2020)
    
    private var years: [Int] = []
    private var months: [String] = []
    private let labelMonths = Calendar.current.monthSymbols
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        
        CoreDataService.shared.getDailyIntake { [weak self] (intakes) in
            self?.historyPerYear = Dictionary(grouping: intakes, by: { ($0.date?.year ?? 0) })
            self?.years = Dictionary(grouping: intakes, by: { ($0.date?.year ?? 0) }).keys.sorted()
        }
        
        months = []
        let groupByMonths = Dictionary(grouping: historyPerYear[Date().year] ?? [], by: { ($0.date?.month ?? 0) }).keys.sorted()
        groupByMonths.forEach { (key) in
            months.append(labelMonths[key - 1])
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
            months = []
            let groupByMonths = Dictionary(grouping: historyPerYear[years[row]] ?? [], by: { ($0.date?.month ?? 0) }).keys.sorted()
            groupByMonths.forEach { (key) in
                months.append(labelMonths[key - 1])
            }
        }
        reloadAllComponents()
        
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

