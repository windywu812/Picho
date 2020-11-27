//
//  FoodHistoryCell.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit

class FoodHistoryCell: UITableViewCell {
    
    static let reuseIdentifier = "FoodHistoryCell"
    
    private var foodNameLabel: UILabel!
    private var calorieLabel: UILabel!
    private var satFatLabel: UILabel!
    private var sugarLabel: UILabel!
    private var howOftenLabel: UILabel!
    
    func setupCell(history: History) {
        foodNameLabel.text = history.foodName
        calorieLabel.text = "\(history.totalCalorie) cal"
        sugarLabel.text = "Sugar - \(history.totalSugar) g"
        satFatLabel.text = "Saturated Fat - \(history.totalSatFat) g"
        howOftenLabel.text = "\(history.eatTimes) times"
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        foodNameLabel = UILabel()
        calorieLabel = UILabel()
        howOftenLabel = UILabel()
        
        satFatLabel = UILabel()
        satFatLabel.textColor = .secondaryLabel
        
        sugarLabel = UILabel()
        sugarLabel.textColor = .secondaryLabel
        
        let rightStack = UIStackView(arrangedSubviews: [calorieLabel, satFatLabel, sugarLabel])
        rightStack.alignment = .trailing
        rightStack.distribution = .equalSpacing
        rightStack.axis = .vertical
        addSubview(rightStack)
        
        rightStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            trailingAnchor: layoutMarginsGuide.trailingAnchor)
        
        let leftStack = UIStackView(arrangedSubviews: [foodNameLabel, howOftenLabel])
        leftStack.alignment = .leading
        leftStack.distribution = .equalCentering
        leftStack.axis = .vertical
        addSubview(leftStack)
        
        leftStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: layoutMarginsGuide.leadingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
