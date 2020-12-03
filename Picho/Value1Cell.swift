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

    private var calorieIntake = 0.0
    private var saturatedFatIntake = 0.0
    private var sugarIntake = 0.0
    private var indicatorImage: UIImageView?

    func setupView(type: Type, amount: Double) {
        switch type {
        case .calorie:
            textLabel?.text = NSLocalizedString("Average Calories", comment: "")
            detailTextLabel?.text = String(format: "%.2f", amount) + " cal"
            let more = amount - calorieIntake
            let percentage = more / calorieIntake * 100
            setupIndicator(percentage: percentage)
        case .saturatedFat:
            textLabel?.text = NSLocalizedString("Average Saturated Fat", comment: "")
            detailTextLabel?.text = String(format: "%.2f", amount) + " g"
            let more = amount - saturatedFatIntake
            let percentage = more / saturatedFatIntake * 100
            setupIndicator(percentage: percentage)
        case .sugar:
            textLabel?.text = NSLocalizedString("Average Sugar", comment: "")
            detailTextLabel?.text = String(format: "%.2f", amount) + " g"
            let more = amount - sugarIntake
            let percentage = more / sugarIntake * 100
            setupIndicator(percentage: percentage)
        }
    }

    private func setupIndicator(percentage: Double) {
        if percentage > 20 {
            indicatorImage?.image = UIImage(named: "red_indicator")
        } else if percentage > 10 {
            indicatorImage?.image = UIImage(named: "yellow_indicator")
        } else {
            indicatorImage?.image = UIImage(named: "green_indicator")
        }
    }

    private func countCalorie() {
        let age = Double(UserDefaultService.age ?? "0") ?? 0.0
        let weight = Double(UserDefaultService.weight ?? "0") ?? 0.0
        let height = Double(UserDefaultService.height ?? "0") ?? 0.0

        if UserDefaultService.gender == "Male" {
            calorieIntake = (10 * weight + 6.25 * height - 5 * age) + 5
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        } else {
            calorieIntake = (10 * weight + 6.25 * height - 5 * age) - 161
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        }
    }

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)

        indicatorImage = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 22, height: 22)))
        accessoryView = indicatorImage
        countCalorie()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
