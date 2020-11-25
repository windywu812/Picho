////
////  SummaryView.swift
////  Picho
////
////  Created by Windy on 13/11/20.
////
//
//import UIKit
//
//class SummaryView: UIView {
//    
//    private var averageCalorie: HorizontalRowView!
//    private var averageSatFat: HorizontalRowView!
//    private var averageSugar: HorizontalRowView!
//    
//    func setupSummary(data: [DailyIntake]) {
//        averageCalorie.setupView(
//            labelText: "Average Calories",
//            amountText: data.getAverage(of: .calorie),
//            icon: "green_indicator")
//        averageSugar.setupView(
//            labelText: "Average Sugar",
//            amountText: data.getAverage(of: .sugar),
//            icon: "red_indicator")
//        averageSatFat.setupView(
//            labelText: "Average Saturated Fat",
//            amountText: data.getAverage(of: .satFat),
//            icon: "yellow_indicator")
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupView()
//        setupLayout()
//    }
//    
//    private func setupView() {
//        averageCalorie = HorizontalRowView()
//        averageSatFat = HorizontalRowView()
//        averageSugar = HorizontalRowView()
//    }
//    
//    private func setupLayout() {
//        averageCalorie.setConstraint(
//            heighAnchorConstant: 44)
//        averageSatFat.setConstraint(
//            heighAnchorConstant: 44)
//        averageSugar.setConstraint(
//            heighAnchorConstant: 44)
//        
//        let mainStack = UIStackView(arrangedSubviews: [averageCalorie, averageSatFat, averageSugar])
//        mainStack.axis = .vertical
//        addSubview(mainStack)
//        
//        mainStack.setConstraint(
//            topAnchor: topAnchor,
//            bottomAnchor: bottomAnchor,
//            leadingAnchor: leadingAnchor,
//            trailingAnchor: trailingAnchor)
//        
//        let divider = UIView()
//        divider.backgroundColor = .tertiaryLabel
//        addSubview(divider)
//        
//        divider.setConstraint(
//            bottomAnchor: bottomAnchor,
//            leadingAnchor: leadingAnchor,
//            trailingAnchor: trailingAnchor,
//            heighAnchorConstant: 1)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
