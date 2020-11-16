//
//  FoodHistory.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit

class FoodHistoryTableView: UITableView {
    
    private var breakfasts: [History] = []
    private var lunches: [History] = []
    private var dinners: [History] = []
    private var snacks: [History] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        
        delegate = self
        dataSource = self
        isScrollEnabled = false
        rowHeight = 90
        register(FoodHistoryCell.self, forCellReuseIdentifier: FoodHistoryCell.reuseIdentifier)
        backgroundColor = Color.background
    }
    
    func setupConsumption(data: [DailyIntake]) {
        breakfasts = data.groupByTime(on: .breakfast).getHistory()
        lunches = data.groupByTime(on: .lunch).getHistory()
        dinners = data.groupByTime(on: .dinner).getHistory()
        snacks = data.groupByTime(on: .snacks).getHistory()
        
        /// Calculate tableview height
        var totalRow = 0
        for section in 0..<numberOfSections {
            totalRow += (numberOfRows(inSection: section))
        }
        let totalHeight = 40 * numberOfSections + (totalRow + 2) * 90
        
        setConstraint(heighAnchorConstant: CGFloat(totalHeight))
        
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FoodHistoryTableView: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return breakfasts.count + 1
        case 1:
            return lunches.count + 1
        case 2:
            return dinners.count + 1
        case 3:
            return snacks.count + 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.setupCell(
                    imageIcon: "breakfast",
                    labelText: "Breakfast",
                    calorie: breakfasts.reduce(0.0, { $0 + $1.totalCalorie }),
                    sugar: breakfasts.reduce(0.0, { $0 + $1.totalSugar }),
                    satFat: breakfasts.reduce(0.0, { $0 + $1.totalSatFat }),
                    isHead: true)
            } else {
                cell.setupCell(
                    labelText: breakfasts[indexPath.row - 1].foodName,
                    howOften: breakfasts[indexPath.row - 1].eatTimes,
                    calorie: breakfasts[indexPath.row - 1].totalCalorie,
                    sugar: breakfasts[indexPath.row - 1].totalSugar,
                    satFat: breakfasts[indexPath.row - 1].totalSatFat,
                    isHead: false)
            }
        case 1:
            if indexPath.row == 0 {
                cell.setupCell(
                    imageIcon: "lunch",
                    labelText: "Lunch",
                    calorie: lunches.reduce(0.0, { $0 + $1.totalCalorie }),
                    sugar: lunches.reduce(0.0, { $0 + $1.totalSugar }),
                    satFat: lunches.reduce(0.0, { $0 + $1.totalSatFat }),
                    isHead: true)
            } else {
                cell.setupCell(
                    labelText: lunches[indexPath.row - 1].foodName,
                    howOften: lunches[indexPath.row - 1].eatTimes,
                    calorie: lunches[indexPath.row - 1].totalCalorie,
                    sugar: lunches[indexPath.row - 1].totalSugar,
                    satFat: lunches[indexPath.row - 1].totalSatFat,
                    isHead: false)
            }
        case 2:
            if indexPath.row == 0 {
                cell.setupCell(
                    imageIcon: "dinner",
                    labelText: "Dinner",
                    calorie: dinners.reduce(0.0, { $0 + $1.totalCalorie }),
                    sugar: dinners.reduce(0.0, { $0 + $1.totalSugar }),
                    satFat: dinners.reduce(0.0, { $0 + $1.totalSatFat }),
                    isHead: true)
            } else {
                cell.setupCell(
                    labelText: dinners[indexPath.row - 1].foodName,
                    howOften: dinners[indexPath.row - 1].eatTimes,
                    calorie: dinners[indexPath.row - 1].totalCalorie,
                    sugar: dinners[indexPath.row - 1].totalSugar,
                    satFat: dinners[indexPath.row - 1].totalSatFat,
                    isHead: false)
            }
        case 3:
            if indexPath.row == 0 {
                cell.setupCell(
                    imageIcon: "snacks",
                    labelText: "Snacks",
                    calorie: snacks.reduce(0.0, { $0 + $1.totalCalorie }),
                    sugar: snacks.reduce(0.0, { $0 + $1.totalSugar }),
                    satFat: snacks.reduce(0.0, { $0 + $1.totalSatFat }),
                    isHead: true)
            } else {
                cell.setupCell(
                    labelText: snacks[indexPath.row - 1].foodName,
                    howOften: snacks[indexPath.row - 1].eatTimes,
                    calorie: snacks[indexPath.row - 1].totalCalorie,
                    sugar: snacks[indexPath.row - 1].totalSugar,
                    satFat: snacks[indexPath.row - 1].totalSatFat,
                    isHead: false)
            }
        default:
            break
        }
        
        return cell
    }
    
}
