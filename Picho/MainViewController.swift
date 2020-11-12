//
//  ViewController.swift
//  iChol
//
//  Created by Muhammad Rasyid khaikal on 02/11/20.
//

import UIKit
import HealthKit

class MainViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    
    private var mainProgressView: MainProgressView!
    private var pichoCardView: PichoCardView!
    
    private var waterCardView: HorizontalView!
    private var activityCardView: HorizontalView!
    private var activityStack: UIStackView!
    
    private var mealTodayView: MealsTodayView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        mainProgressView.calorieProgress.animate()
        mainProgressView.sugarProgress.animate()
        mainProgressView.satFatProgress.animate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today"
        
//        checkUser()
        
        setupScrollView()
        setupMainProgress()
        setupPichoCard()
        setupActivity()
        setupMealTodayView()
        setupGesture()
    }
    
    private func checkUser() {
        if !UserDefaultService.hasLaunched {
            //show onboarding
            let vc = PageControlDescription()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func setupGesture() {
        let tapActivity = UITapGestureRecognizer(target: self, action: #selector(handleActivity))
        activityCardView.addGestureRecognizer(tapActivity)
        
        let tapWater = UITapGestureRecognizer(target: self, action: #selector(handleWater))
        waterCardView.addGestureRecognizer(tapWater)
    }
    
    @objc private func handleActivity() {
        let vc = UINavigationController(rootViewController: ActivityViewController())
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc private func handleWater() {
        let vc = UINavigationController(rootViewController: WaterViewController())
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = Color.background
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupMainProgress() {
        mainProgressView = MainProgressView()
        scrollView.addSubview(mainProgressView)
        
        mainProgressView.setConstraint(
            topAnchor: scrollView.topAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 206)
    }
    
    private func setupPichoCard() {
        pichoCardView = PichoCardView(
            mascot: "mascot_sad",
            title: "You haven't started!",
            detail: "Start by logging in what you eat today",
            buttonText: "Log Breakfast",
            rootView: self)
        scrollView.addSubview(pichoCardView)
        
        pichoCardView.setConstraint(
            topAnchor: mainProgressView.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 130)
    }
    
    private func setupActivity() {
        waterCardView = HorizontalView(
            labelText: "Water",
            detailText: "💧 8 cups remaining",
            iconImage: UIImage(),
            background: Color.blue)
        waterCardView.setConstraint(heighAnchorConstant: 46)
        
        activityCardView = HorizontalView(
            labelText: "Activity",
            detailText: "🔥 300cal",
            iconImage: UIImage(),
            background: Color.red)
        activityCardView.setConstraint(heighAnchorConstant: 46)
        
        activityStack = UIStackView(arrangedSubviews: [waterCardView, activityCardView])
        activityStack.spacing = 16
        activityStack.axis = .vertical
        scrollView.addSubview(activityStack)
        
        activityStack.setConstraint(
            topAnchor: pichoCardView.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    private func setupMealTodayView() {
        mealTodayView = MealsTodayView(rootView: self)
        scrollView.addSubview(mealTodayView)
        
        mealTodayView.setConstraint(
            topAnchor: activityStack.bottomAnchor, topAnchorConstant: 24,
            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
}

