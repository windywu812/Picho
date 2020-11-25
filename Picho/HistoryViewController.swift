//
//  ProgressViewController.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit
import Charts

class HistoryTableViewController: UITableViewController {
    
    private let viewModel = HistoryViewModel()
    
    private var dataWeekOfMonth: [DailyIntake] = []
    private var breakfasts: [History] = []
    private var lunches: [History] = []
    private var dinners: [History] = []
    private var snacks: [History] = []
    
    private var progressView: ChartViewCell?
    
    private var selectedMonth = Date().month
    private var selectedWeek = Date().weekOfMonth
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchData()
        progressView?.chartView.lineChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "Progress"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        tableView.register(FoodHistoryCell.self, forCellReuseIdentifier: FoodHistoryCell.reuseIdentifier)
        tableView.register(Value1Cell.self, forCellReuseIdentifier: Value1Cell.reuseIdentifier)
        tableView.register(FoodHistoryCell.self, forCellReuseIdentifier: FoodHistoryCell.reuseIdentifier)
        
        view.backgroundColor = Color.background
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func handleDismiss() {
        view.endEditing(true)
    }
    
    private func fetchConsupmtionPerWeek(month: Int = Date().month, week: Int) {
        let formatterWithoutYear = DateFormatter()
        formatterWithoutYear.dateFormat = "dd MMM"
        
        dataWeekOfMonth = viewModel.getDataWeekofMonth(in: month)[week] ?? []
        breakfasts = dataWeekOfMonth.groupByTime(on: .breakfast).getHistory()
        lunches = dataWeekOfMonth.groupByTime(on: .lunch).getHistory()
        dinners = dataWeekOfMonth.groupByTime(on: .dinner).getHistory()
        snacks = dataWeekOfMonth.groupByTime(on: .snacks).getHistory()
        
        selectedMonth = month
        selectedWeek = week
        
        tableView.reloadData()
    }
    
    func selectedChart(week: Int) {
        fetchConsupmtionPerWeek(month: selectedMonth, week: week)
    }
    
    func sendDate(date: (Int, Int)) {
        selectedMonth = date.0
        fetchConsupmtionPerWeek(month: date.0, week: 1)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return breakfasts.count + 1
        case 2:
            return lunches.count + 1
        case 3:
            return dinners.count + 1
        case 4:
            return snacks.count + 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Value1Cell.reuseIdentifier, for: indexPath) as! Value1Cell
            cell.selectionStyle = .none
            if indexPath.row == 0 {
                cell.setupView(type: .calorie, amount: dataWeekOfMonth.getAverage(of: .calorie))
            } else if indexPath.row == 1 {
                cell.setupView(type: .saturatedFat, amount: dataWeekOfMonth.getAverage(of: .calorie))
            } else if indexPath.row == 2 {
                cell.setupView(type: .sugar, amount: dataWeekOfMonth.getAverage(of: .calorie))
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
            cell.selectionStyle = .none
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
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
            cell.selectionStyle = .none
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
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
            cell.selectionStyle = .none
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
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
            cell.selectionStyle = .none
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
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            progressView = ChartViewCell()
            progressView?.viewModel = viewModel
            progressView?.chartView.delegate = self
            progressView?.setupChart(month: selectedMonth, week: selectedWeek)
            return progressView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return IndicatorLabelView()
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HistoryTableViewController: ChartSeletedDelegate {
    
    
    
}

