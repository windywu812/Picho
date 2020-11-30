//
//  ServingCell.swift
//  Picho
//
//  Created by Windy on 30/11/20.
//

import UIKit
import Combine

class ServingCell: UITableViewCell {
    
    static let reuseIdentifier = "ServingCell"
    
    private var cancelable = Set<AnyCancellable>()
    var servingTf: UITextField!
    
    var parent: FoodDetailScreen?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        textLabel?.text = "Serving Size"
        detailTextLabel?.text = ""
        
        let unit = UILabel()
        unit.text = "g"
        unit.textColor = .secondaryLabel
        
        servingTf = UITextField()
        servingTf.textAlignment = .right
        servingTf.textColor = .secondaryLabel
        servingTf.keyboardType = .numberPad
        
        let mainStack = UIStackView(arrangedSubviews: [servingTf, unit])
        mainStack.spacing = 4
        addSubview(mainStack)
        
        mainStack.setConstraint(
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            centerYAnchor: centerYAnchor,
            heighAnchorConstant: 30,
            widthAnchorConstant: 100)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: servingTf)
            .map({ (($0.object as! UITextField).text ?? "") })
            .filter({ !$0.isEmpty })
            .sink { text in
                if !text.isEmpty {
                    let serving = (Double(text) ?? 100) / 100
                    
                    guard let food = self.parent?.containerFood else { return }
                    
                    let newData = FoodDetail(
                        foodId: food.foodId,
                        nameId: food.nameId,
                        nameEn: food.nameEn,
                        serving: serving,
                        calories: food.calories * serving,
                        calorieFromFat: food.calorieFromFat * serving,
                        totalFat: food.totalFat * serving,
                        saturatedFat: food.saturatedFat * serving,
                        transFat: food.transFat * serving,
                        cholesterol: food.cholesterol * serving,
                        sodium: food.sodium * serving,
                        totalCarbs: food.totalCarbs * serving,
                        fiber: food.fiber * serving,
                        sugar: food.sugar * serving,
                        protein: food.protein * serving,
                        vitaminA: food.vitaminA * serving,
                        calcium: food.calcium * serving,
                        vitaminC: food.vitaminC * serving,
                        iron: food.iron * serving)
                    self.parent?.food = newData
                    
                    let section1Amount = [newData.calories, newData.saturatedFat, newData.sugar]
                    let section2Amount = [newData.serving]
                    let section3Amount = [newData.totalFat, newData.calorieFromFat, newData.transFat, newData.cholesterol]
                    let section4Amount = [newData.cholesterol, newData.protein, newData.fiber, newData.sodium, newData.calcium, newData.iron]
                    let section5Amount = [newData.vitaminA, newData.vitaminC]
                    self.parent?.nutritionAmount = [section1Amount, section2Amount, section3Amount, section4Amount, section5Amount]
                    
                    self.parent?.tableView.reloadSections(IndexSet(arrayLiteral: 0, 2, 3, 4), with: .automatic)
                }
            }
            .store(in: &cancelable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

