//
//  ProgressViewController.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit
import Charts

class HistoryViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var chartView: ChartView!
    private var sugarLegend: LegendView!
    private var satFatLegend: LegendView!
    private var timeLabel: UILabel!
    private var summaryView: SummaryView!
    private var indicator: IndicatorLabelView!
    private var foodHistory: FoodHistory!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        chartView.chartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Progress"
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        chartView = ChartView()
        chartView.layer.cornerRadius = 16
        scrollView.addSubview(chartView)
        
        sugarLegend = LegendView(text: "Sugar", color: Color.green)
        satFatLegend = LegendView(text: "Saturated Fat", color: Color.yellow)
        
        timeLabel = UILabel()
        timeLabel.setFont(text: "2 Nov - 8 Nov", size: 22, weight: .bold)
        summaryView = SummaryView()
        
        indicator = IndicatorLabelView()
        
        foodHistory = FoodHistory()
        
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(satFatLegend)
        scrollView.addSubview(sugarLegend)
        scrollView.addSubview(summaryView)
        scrollView.addSubview(indicator)
        scrollView.addSubview(foodHistory)
    }
    
    private func setupLayout() {
        scrollView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor)
        
        chartView.setConstraint(
            topAnchor: scrollView.topAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 336)
        
        sugarLegend.setConstraint(
            topAnchor: chartView.bottomAnchor, topAnchorConstant: 8,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            heighAnchorConstant: 44,
            widthAnchorConstant: UIScreen.main.bounds.width / 2 - 24)
        
        satFatLegend.setConstraint(
            topAnchor: chartView.bottomAnchor, topAnchorConstant: 8,
            leadingAnchor: sugarLegend.trailingAnchor, leadingAnchorConstant: 8,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 44)
        
        timeLabel.setConstraint(
            topAnchor: sugarLegend.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor)
        
        summaryView.setConstraint(
            topAnchor: timeLabel.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor,
            heighAnchorConstant: 44 * 3)
        
        indicator.setConstraint(
            topAnchor: summaryView.bottomAnchor, topAnchorConstant: 24,
//            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: -40,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)

        foodHistory.setConstraint(
            topAnchor: indicator.bottomAnchor, topAnchorConstant: 24,
            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: -24,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor)
    }
    
}


class FoodHistory: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        
        delegate = self
        dataSource = self
        isScrollEnabled = false
        rowHeight = 90
        register(FoodHistoryCell.self, forCellReuseIdentifier: FoodHistoryCell.reuseIdentifier)
        
        /// Calculate tableview height
        var totalRow = 0
        for section in 0..<numberOfSections {
            totalRow += numberOfRows(inSection: section)
        }
        let totalHeight = 40 * numberOfSections + totalRow * 90
        
        setConstraint(
            heighAnchorConstant: CGFloat(totalHeight))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FoodHistory: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.setupCell(imageIcon: "breakfast", labelText: "Breakfast", calorie: 431, sugar: 21, satFat: 13, isHead: true)
            }
        case 1:
            if indexPath.row == 0 {
                cell.setupCell(imageIcon: "lunch", labelText: "Lunch", calorie: 431, sugar: 21, satFat: 13, isHead: true)
            }
        case 2:
            if indexPath.row == 0 {
                cell.setupCell(imageIcon: "dinner", labelText: "Dinner", calorie: 431, sugar: 21, satFat: 13, isHead: true)
            }
        default:
            break
        }
        
        if indexPath.row != 0 {
            cell.setupCell(labelText: "Nasi lemak", howOften: 8, calorie: 243, sugar: 33, satFat: 33, isHead: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return HeaderView()
        }
        return nil
    }
    
}

class HeaderView: UIView {
    
    private var label: UILabel!
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        print("Tap")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel()
        label.setFont(text: ("Highest Week Comsuption").uppercased(), size: 13, color: .secondaryLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        
        addSubview(label)
        backgroundColor = Color.background
        
        label.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: layoutMarginsGuide.leadingAnchor,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class FoodHistoryCell: UITableViewCell {
    
    static let reuseIdentifier = "FoodHistoryCell"
    
    private var icon: UIImageView!
    private var foodNameLabel: UILabel!
    private var calorieLabel: UILabel!
    private var satFatLabel: UILabel!
    private var sugarLabel: UILabel!
    private var howOftenLabel: UILabel!
    
    func setupCell(imageIcon: String = "", labelText: String, howOften: Int = 0, calorie: Double, sugar: Double, satFat: Double, isHead: Bool) {
        
        if isHead {
            icon.image = UIImage(named: imageIcon)
            foodNameLabel.setFont(text: labelText, weight: .bold)
            calorieLabel.setFont(text: "\(calorie) cal", weight: .bold)
            sugarLabel.setFont(text: "Sugar - \(sugar) g", weight: .bold, color: .secondaryLabel)
            satFatLabel.setFont(text: "Saturated Fat - \(satFat) g", weight: .bold, color: .secondaryLabel)
            howOftenLabel.text = ""
        } else {
            icon.removeFromSuperview()
            foodNameLabel.text = labelText
            calorieLabel.text = "\(calorie) cal"
            sugarLabel.text = "Sugar - \(sugar) g"
            satFatLabel.text = "Saturated Fat - \(satFat) g"
            howOftenLabel.text = "\(howOften) times"
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        icon = UIImageView()
        
        foodNameLabel = UILabel()
        foodNameLabel.text = "Nasi Lemak"
        
        calorieLabel = UILabel()
        calorieLabel.text = "432 cal"
        
        satFatLabel = UILabel()
        satFatLabel.setFont(text: "Saturated Fat - 9g", color: .secondaryLabel)
        
        sugarLabel = UILabel()
        sugarLabel.setFont(text: "Sugar - 9g", color: .secondaryLabel)
        
        howOftenLabel = UILabel()
        howOftenLabel.text = "7 times"
        
        let titleStack = UIStackView(arrangedSubviews: [icon, foodNameLabel])
        titleStack.spacing = 4
        icon.setConstraint(
            heighAnchorConstant: 22, widthAnchorConstant: 22)
        
        let leftStack = UIStackView(arrangedSubviews: [titleStack, howOftenLabel])
        leftStack.alignment = .leading
        leftStack.distribution = .equalCentering
        leftStack.axis = .vertical
        addSubview(leftStack)
        
        leftStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: layoutMarginsGuide.leadingAnchor)
        
        let rightStack = UIStackView(arrangedSubviews: [calorieLabel, satFatLabel, sugarLabel])
        rightStack.alignment = .trailing
        rightStack.distribution = .equalSpacing
        rightStack.axis = .vertical
        addSubview(rightStack)
        
        rightStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            trailingAnchor: layoutMarginsGuide.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
