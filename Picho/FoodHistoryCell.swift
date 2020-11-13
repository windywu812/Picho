//
//  FoodHistoryCell.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit

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
