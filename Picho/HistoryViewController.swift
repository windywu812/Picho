//
//  ProgressViewController.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit
import Charts

class HistoryViewModel {
    
    var allHistoryData: [Int: [DailyIntake]] = [:]
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        CoreDataService.shared.getDailyIntake { [weak self] (intakes) in
            self?.allHistoryData = Dictionary(grouping: intakes, by: { ($0.date?.month ?? 0) })
        }
    }
    
    func getDataWeekofMonth(in month: Int) -> [Int?: [DailyIntake]] {
        /// Get data in one month
        let dataByMonth = allHistoryData[month]
        /// Get data in all weeks in one month
        let groupMyWeek = Dictionary(grouping: dataByMonth ?? [], by: { $0.date?.weekOfMonth })
        return groupMyWeek
    }
    
    // MARK: Dummy Data Sets
//        for i in -90...0 {
//            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .breakfast)
//            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .lunch)
//            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .dinner)
//            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: "FoodId", name: "FoodName", description: "FoodDescription", calorie: Double(Int.random(in: 0...300)), saturatedFat: Double(Int.random(in: 0...300)), sugars: Double(Int.random(in: 0...300)), date: Date().add(i), time: .snacks)
//        }
    
    
}

class HistoryViewController: UIViewController {
    
    private let viewModel = HistoryViewModel()
    
    private var scrollView: UIScrollView!
    private var chartView: ChartView!
    private var sugarLegend: LegendView!
    private var satFatLegend: LegendView!
    private var timeLabel: UILabel!
    private var summaryView: SummaryView!
    private var indicator: IndicatorLabelView!
    private var foodHistory: FoodHistory!
    
    private var breakfasts: [DailyIntake] = []
    private var lunches: [DailyIntake] = []
    private var dinners: [DailyIntake] = []
    private var snacks: [DailyIntake] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        chartView.lineChartView.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
        chartView.dataWeekPerMonth = viewModel.getDataWeekofMonth(in: Date().month)
        chartView.setupChartData()
        
        fetchConsupmtionPerWeek(week: 1)
    }
    
    private func fetchConsupmtionPerWeek(month: Int = Date().month, week: Int) {
        let formatterWithoutYear = DateFormatter()
        formatterWithoutYear.dateFormat = "dd MMM"
        
        let firstDateOfWeek = formatterWithoutYear.string(from: viewModel.getDataWeekofMonth(in: 10)[week]?.first?.date ?? Date())
        let lastDataOfWeek = formatterWithoutYear.string(from: viewModel.getDataWeekofMonth(in: 10)[week]?.last?.date ?? Date())
        
        timeLabel.text = "\(firstDateOfWeek) - \(lastDataOfWeek)"
        
        chartView.dataWeekPerMonth = viewModel.getDataWeekofMonth(in: month)
        chartView.setupChartData()
        
        summaryView.setupSummary(data: viewModel.getDataWeekofMonth(in: month)[week] ?? [])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Progress"
        
        setupView()
        setupLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func handleDismiss() {
        view.endEditing(true)
    }
    
}

extension HistoryViewController: ChartSeletedDelegate {
    
    func sendDate(date: (Int, Int)) {
        fetchConsupmtionPerWeek(month: date.0, week: 1)
    }
    
    func selectedChart(week: Int) {
        fetchConsupmtionPerWeek(week: week + 1)
    }
    
}

extension HistoryViewController {
    
    private func setupView() {
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        chartView = ChartView()
        chartView.delegate = self
        chartView.viewModel = viewModel
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
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)

        foodHistory.setConstraint(
            topAnchor: indicator.bottomAnchor, topAnchorConstant: 24,
            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: -24,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor)
    }
    
}
