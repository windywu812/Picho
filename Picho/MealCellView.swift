//
//  MealCellView.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

class MealCellView: UIView {
    
    private var iconView: UIImageView
    private var titleLabel: UILabel
    private var detaiLabel: UILabel
    private var totalCalorieLabel: UILabel
    private var button: UIButton
    private let rootView: UIViewController
    
    var eatingTime: EatTime = .breakfast
    
    func setData(foods: [DailyIntake]) {
        let mappedFoods = foods.map { $0.name ?? "" }
        let mappedCalories = foods.map { $0.calorie }
        let loggedFoods = mappedFoods.joined(separator: "\n")
        let loggedCalories = mappedCalories.reduce(0.0, +)
        
        detaiLabel.text = loggedFoods
        totalCalorieLabel.text = "\(Int(loggedCalories)) cal"
    }
    
    init(frame: CGRect = .zero,
         iconImage: String,
         title: String,
         buttonText: String,
         foods: [DailyIntake],
         rootView: UIViewController
    ) {
        
        button = UIButton(type: .system)
        iconView = UIImageView()
        titleLabel = UILabel()
        detaiLabel = UILabel()
        totalCalorieLabel = UILabel()
        self.rootView = rootView
        
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(detaiLabel)
        addSubview(totalCalorieLabel)
        addSubview(button)
        
        layer.cornerRadius = 16
        backgroundColor = .white
        
        iconView.image = UIImage(named: iconImage)
        iconView.contentMode = .scaleToFill
        
        titleLabel.setFont(text: title, size: 17, weight: .bold)
        
        let mappedFoods = foods.map { $0.name ?? "" }
        let mappedCalories = foods.map { $0.calorie }
        let loggedFoods = mappedFoods.joined(separator: "\n")
        let loggedCalories = mappedCalories.reduce(0.0, +)
        
        detaiLabel.setFont(text: loggedFoods, size: 15)
        detaiLabel.numberOfLines = 3
        
        button.tintColor = Color.green
        button.setAttributedTitle(NSAttributedString.bodyFont(text: buttonText), for: .normal)
        button.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
        
        totalCalorieLabel.setFont(text: "\(Int(loggedCalories)) cal", size: 17, weight: .bold)
        
        setupLayout()
    }
    
    @objc func handleTap(sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Add Breakfast":
            let vc = FoodInputViewController()
            vc.eatingTime = EatTime.breakfast
            rootView.navigationController?.pushViewController(vc, animated: true)
        case "Add Lunch":
            let vc = FoodInputViewController()
            vc.eatingTime = EatTime.lunch
            rootView.navigationController?.pushViewController(vc, animated: true)
        case "Add Dinner":
            let vc = FoodInputViewController()
            vc.eatingTime = EatTime.dinner
            rootView.navigationController?.pushViewController(vc, animated: true)
        case "Add Snacks":
            let vc = FoodInputViewController()
            vc.eatingTime = EatTime.snacks
            rootView.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    private func setupLayout() {
        iconView.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            heighAnchorConstant: 60, widthAnchorConstant: 60)
        
        totalCalorieLabel.setConstraint(
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16)
        
        titleLabel.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: iconView.trailingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16)
        
        detaiLabel.setConstraint(
            topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 4,
            leadingAnchor: iconView.trailingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16)
        
        let buttonImageLabel = UIImageView()
        buttonImageLabel.image = UIImage(named: "arrow_left_square")
        buttonImageLabel.contentMode = .scaleAspectFit
        
        let buttonStack = UIStackView(arrangedSubviews: [button, buttonImageLabel])
        buttonStack.spacing = 8
        buttonStack.axis = .horizontal
        addSubview(buttonStack)
        
        buttonStack.setConstraint(
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16)
        
        buttonImageLabel.setConstraint(
            heighAnchorConstant: 20, widthAnchorConstant: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
