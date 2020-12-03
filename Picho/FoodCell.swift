//
//  FoodCell.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import UIKit

class FoodCell: UITableViewCell {
    static let reuseIdentifier = "FoodCell"

    private var nameLabel: UILabel!
    private var calorieLabel: UILabel!
    private var fatLabel: UILabel!
    private var sugarLabel: UILabel!

    func configureCell(foodName: String, calorie: Double, fat: Double, sugar: Double) {
        nameLabel.text = foodName
        fatLabel.text = "Fat: \(String(fat))g"
        calorieLabel.text = "Calories: \(String(calorie))cal"
        sugarLabel.text = "Sugar: \(String(sugar))g"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white

        nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nameLabel.textColor = .black
        nameLabel.lineBreakMode = .byTruncatingTail

        calorieLabel = UILabel()
        calorieLabel.textColor = .secondaryLabel

        fatLabel = UILabel()
        sugarLabel = UILabel()
        fatLabel.textColor = .secondaryLabel
        sugarLabel.textColor = .secondaryLabel

        let mainStack = UIStackView(arrangedSubviews: [nameLabel, calorieLabel, fatLabel, sugarLabel])
        mainStack.spacing = 4
        mainStack.axis = .vertical
        mainStack.alignment = .leading
        addSubview(mainStack)

        mainStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: layoutMarginsGuide.leadingAnchor,
            trailingAnchor: layoutMarginsGuide.trailingAnchor
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
