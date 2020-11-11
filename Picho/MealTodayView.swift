//
//  MealsTodayView.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

class MealsTodayView: UIView {
    
    private let title: UILabel
    private let rootView: UIViewController
    
    var breakFastCard: MealCellView!
    var lunchCard: MealCellView!
    var dinnerCard: MealCellView!
    var snackCard: MealCellView!
    
    init(frame: CGRect = .zero, rootView: UIViewController) {
        
        title = UILabel()
        self.rootView = rootView
        
        super.init(frame: frame)
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        
        let tapBreakfast = UITapGestureRecognizer(target: self, action: #selector(handleBreakfast(sender:)))
        let tapLunch = UITapGestureRecognizer(target: self, action: #selector(handleLunch(sender:)))
        let tapDinner = UITapGestureRecognizer(target: self, action: #selector(handleDinner(sender:)))
        let tapSnack = UITapGestureRecognizer(target: self, action: #selector(handleDinner(sender:)))
        
        title.setFont(text: "Meals Today", size: 22, weight: .bold)
        
        breakFastCard = MealCellView(iconImage: "breakfast", title: "Breakfast", buttonText: "Add Breakfast")
        breakFastCard.addGestureRecognizer(tapBreakfast)
        
        lunchCard = MealCellView(iconImage: "lunch", title: "Lunch", buttonText: "Add Lunch")
        lunchCard.addGestureRecognizer(tapLunch)
        
        dinnerCard = MealCellView(iconImage: "dinner", title: "Dinner", buttonText: "Add Dinner")
        dinnerCard.addGestureRecognizer(tapDinner)
        
        snackCard = MealCellView(iconImage: "lunch", title: "Snacks", buttonText: "Add Snacks")
        snackCard.addGestureRecognizer(tapSnack)
        
        addSubview(title)
        addSubview(breakFastCard)
        addSubview(lunchCard)
        addSubview(dinnerCard)
        addSubview(snackCard)
    }
    
    @objc private func handleBreakfast(sender: UITapGestureRecognizer) {
//        let vc = FoodInputViewController()
//        vc.timeLabel = "Breakfast"
//        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleLunch(sender: UITapGestureRecognizer) {
//        let vc = FoodInputViewController()
//        vc.timeLabel = "Lunch"
//        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleDinner(sender: UITapGestureRecognizer) {
//        let vc = FoodInputViewController()
//        vc.timeLabel = "Dinner"
//        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleSnacks(sender: UITapGestureRecognizer) {
//        let vc = FoodInputViewController()
//        vc.timeLabel = "Lunch"
//        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupLayout() {
        title.setConstraint(
            topAnchor: topAnchor,
            leadingAnchor: leadingAnchor)
        
        let mainStack = UIStackView(arrangedSubviews: [breakFastCard, lunchCard, dinnerCard, snackCard])
        mainStack.spacing = 16
        mainStack.axis = .vertical
        addSubview(mainStack)
        
        mainStack.setConstraint(
            topAnchor: title.bottomAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor)
        
        breakFastCard.setConstraint(heighAnchorConstant: 140)
        lunchCard.setConstraint(heighAnchorConstant: 140)
        dinnerCard.setConstraint(heighAnchorConstant: 140)
        snackCard.setConstraint(heighAnchorConstant: 140)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

