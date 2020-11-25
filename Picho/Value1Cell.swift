//
//  ProfileCell.swift
//  iChol
//
//  Created by Windy on 08/11/20.
//

import UIKit

enum Type {
    case calorie
    case saturatedFat
    case sugar
}

class Value1Cell: UITableViewCell {
    
    static let reuseIdentifier = "Value1Cell"
    
    private var calorieIntake = 0
    private var saturatedFatIntake = 0
    private var sugarIntake = 0
    
    func setupView(type: Type, amount: Double) {
        
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 22, height: 22)))
        accessoryView = imageView
        
        countTotal()
        
        switch type {
        
        case .calorie:
            textLabel?.text = "Average Calories"
            detailTextLabel?.text = String(format: "%.2f", amount) + " cal"
            imageView.image = UIImage(named: "red_indicator")
            
        case .saturatedFat:
            textLabel?.text = "Average Saturated Fat"
            detailTextLabel?.text = String(format: "%.2f", amount) + " g"
            imageView.image = UIImage(named: "green_indicator")
        case .sugar:
            textLabel?.text = "Average Sugar"
            detailTextLabel?.text = String(format: "%.2f", amount) + " g"
            imageView.image = UIImage(named: "yellow_indicator")
        }
    }
    
    private func countTotal() {
        let age = Double(UserDefaultService.age ?? String(0))
        let weight = Double(UserDefaultService.weight ?? String(0))
        let height = Double(UserDefaultService.height ?? String(0))
        
        if UserDefaultService.gender == "Male" {
            calorieIntake = (10 * weight) + (6.25 * height) - (5 * age) + 5
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        } else {
            calorieIntake = (10 * weight) + (6.25 * height) - (5 * age) - 161
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
