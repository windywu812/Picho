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
    
    func setData(detail: String, totalCalorie: Double) {
        detaiLabel.text = detail
        totalCalorieLabel.text = "\(totalCalorie)"
    }
    
    init(frame: CGRect = .zero,
         iconImage: String,
         title: String,
         buttonText: String,
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
        
        detaiLabel.setFont(text: "Food Names 1\nFood Names 2\nFood Names 3\nFood Names 4", size: 15)
        detaiLabel.numberOfLines = 3
        
        button.tintColor = Color.green
        button.setAttributedTitle(NSAttributedString.bodyFont(text: buttonText), for: .normal)
        button.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
        
        totalCalorieLabel.setFont(text: "322 cal", size: 17, weight: .bold)
        
        setupLayout()
    }
    
    @objc func handleTap(sender: UIButton) {
        switch sender.titleLabel?.text {
        case "Add Breakfast":
            let vc = FoodInputViewController()
            vc.timeLabel = "Breakfast"
            rootView.navigationController?.pushViewController(vc, animated: true)
        case "Add Lunch":
            let vc = FoodInputViewController()
            vc.timeLabel = "Lunch"
            rootView.navigationController?.pushViewController(vc, animated: true)
        case "Add Dinner":
            let vc = FoodInputViewController()
            vc.timeLabel = "Dinner"
            rootView.navigationController?.pushViewController(vc, animated: true)
        case "Add Snacks":
            let vc = FoodInputViewController()
            vc.timeLabel = "Snacks"
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
