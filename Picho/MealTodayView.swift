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
    
    private var breakfasts: [DailyIntake] = []
    private var lunches: [DailyIntake] = []
    private var dinners: [DailyIntake] = []
    private var snacks: [DailyIntake] = []
    
    var breakFastCard: MealCellView!
    var lunchCard: MealCellView!
    var dinnerCard: MealCellView!
    var snackCard: MealCellView!
    
    init(frame: CGRect = .zero, rootView: UIViewController) {
        
        title = UILabel()
        self.rootView = rootView
        
        super.init(frame: frame)
        
        fetchDailyIntake()
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        
        let tapBreakfast = UITapGestureRecognizer(target: self, action: #selector(handleBreakfast(sender:)))
        let tapLunch = UITapGestureRecognizer(target: self, action: #selector(handleLunch(sender:)))
        let tapDinner = UITapGestureRecognizer(target: self, action: #selector(handleDinner(sender:)))
        let tapSnack = UITapGestureRecognizer(target: self, action: #selector(handleSnacks(sender:)))
        
        title.setFont(text: "Meals Today", size: 22, weight: .bold)
        
        breakFastCard = MealCellView(iconImage: "breakfast", title: EatTime.breakfast.rawValue.capitalized, buttonText: "Add Breakfast", foods: breakfasts, rootView: rootView)
        breakFastCard.addGestureRecognizer(tapBreakfast)
        
        lunchCard = MealCellView(iconImage: "lunch", title: EatTime.lunch.rawValue.capitalized, buttonText: "Add Lunch", foods: lunches, rootView: rootView)
        lunchCard.addGestureRecognizer(tapLunch)
        
        dinnerCard = MealCellView(iconImage: "dinner", title: EatTime.dinner.rawValue.capitalized, buttonText: "Add Dinner", foods: dinners,  rootView: rootView)
        dinnerCard.addGestureRecognizer(tapDinner)
        
        snackCard = MealCellView(iconImage: "snacks", title: EatTime.snacks.rawValue.capitalized, buttonText: "Add Snacks", foods: snacks, rootView: rootView)
        snackCard.addGestureRecognizer(tapSnack)
        
        addSubview(title)
        addSubview(breakFastCard)
        addSubview(lunchCard)
        addSubview(dinnerCard)
        addSubview(snackCard)
    }
    
    @objc private func handleBreakfast(sender: UITapGestureRecognizer) {
        let vc = FoodInputViewController()
        vc.eatingTime = .breakfast
        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleLunch(sender: UITapGestureRecognizer) {
        let vc = FoodInputViewController()
        vc.eatingTime = .lunch
        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleDinner(sender: UITapGestureRecognizer) {
        let vc = FoodInputViewController()
        vc.eatingTime = .dinner
        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func handleSnacks(sender: UITapGestureRecognizer) {
        let vc = FoodInputViewController()
        vc.eatingTime = .snacks
        rootView.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func fetchDailyIntake() {
        CoreDataService.shared.getDailyIntake(time: .breakfast, date: Date()) { intakes in
            self.breakfasts = intakes
        }
        CoreDataService.shared.getDailyIntake(time: .lunch, date: Date()) { intakes in
            self.lunches = intakes
        }
        CoreDataService.shared.getDailyIntake(time: .dinner, date: Date()) { intakes in
            self.dinners = intakes
        }
        CoreDataService.shared.getDailyIntake(time: .snacks, date: Date()) { intakes in
            self.snacks = intakes
        }
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

