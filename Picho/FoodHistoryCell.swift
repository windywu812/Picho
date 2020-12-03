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
        let totalSgr = "\(history.totalSugar)"
        let totalSatFat = "\(history.totalSatFat)"
        let totalEat = "\(history.eatTimes)"

        foodNameLabel.text = history.foodName
        calorieLabel.text = "\(history.totalCalorie) cal"
        sugarLabel.text = String(format: NSLocalizedString("Sugar - %@ g", comment: ""), totalSgr)
        satFatLabel.text = String(format: NSLocalizedString("Saturated Fat - %@ g", comment: ""), totalSatFat)
        howOftenLabel.text = String(format: NSLocalizedString("%@ Times", comment: ""), totalEat)
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
            trailingAnchor: layoutMarginsGuide.trailingAnchor
        )

        let leftStack = UIStackView(arrangedSubviews: [foodNameLabel, howOftenLabel])
        leftStack.alignment = .leading
        leftStack.distribution = .equalCentering
        leftStack.axis = .vertical
        addSubview(leftStack)

        leftStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: layoutMarginsGuide.leadingAnchor
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
