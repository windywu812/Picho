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
//    private var logButton: UIButton!
    
    var isLogged = false
    
    func configureCell(foodName: String, description: String) {
        nameLabel.text = foodName
        
        let components = description.split(separator: "|")
        let calories = components[0]
        var fat = components[1]
        fat.removeFirst()
        var sugar = components[3]
        sugar.removeFirst()

        fatLabel.text = String(fat)
        calorieLabel.text = String(calories)
        sugarLabel.text = String(sugar)
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
            trailingAnchor: layoutMarginsGuide.trailingAnchor)
    }
    
    @objc private func handleLogging() {
        print("Logged")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
