//
//  FoodHeaderCell.swift
//  Picho
//
//  Created by Windy on 25/11/20.
//

import UIKit

class FoodHeaderCell: UITableViewCell {
    
    static let reuseIdentifier = "FoodHeaderCell"
    
    private var icon: UIImageView!
    private var foodNameLabel: UILabel!
    private var calorieLabel: UILabel!
    private var satFatLabel: UILabel!
    private var sugarLabel: UILabel!
    private var howOftenLabel: UILabel!
    
    func setupCell(imageIcon: String = "", labelText: String = "", calorie: Double = 0.0, sugar: Double = 0.0, satFat: Double = 0.0) {

        icon.image = UIImage(named: imageIcon)
        foodNameLabel.setFont(text: labelText, weight: .bold)
        calorieLabel.setFont(text: "\(calorie) cal", weight: .bold)
        sugarLabel.setFont(text: "Sugar - \(sugar) g", weight: .bold, color: .secondaryLabel)
        satFatLabel.setFont(text: "Saturated Fat - \(satFat) g", weight: .bold, color: .secondaryLabel)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        icon = UIImageView()
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
        
        let titleStack = UIStackView(arrangedSubviews: [icon, foodNameLabel].compactMap({ $0 }))
        titleStack.spacing = 4
        icon?.setConstraint(heighAnchorConstant: 22, widthAnchorConstant: 22)
        
        let leftStack = UIStackView(arrangedSubviews: [titleStack, howOftenLabel])
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
