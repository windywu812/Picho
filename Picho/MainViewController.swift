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
    
    private var calorieIntake : Double = 0.0
    private var saturatedFatIntake : Double = 0.0
    private var sugarIntake : Double = 0.0
    
    private var calorieLeft : Double = 0.0
    private var satFatLeft : Double = 0.0
    private var sugarLeft : Double = 0.0
    private var totalStep : Double = 0.0
    private var totalWater : Double = 0.0
    
    private let age = Double(UserDefaultService.age)
    private let weight = Double(UserDefaultService.weight)
    private let height = Double(UserDefaultService.height)
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
 
        fetchData()
        passData()
        waterCardView.setupViewWater(amount: Int(totalWater))
        activityCardView.setupViewActivity(amount: Int(totalStep))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today"
        
        checkUser()
        countCalorie()
        fetchData()
      
        setupScrollView()
        setupMainProgress()
        setupPichoCard()
        setupActivity()
        setupMealTodayView()
    }
    
    private func checkUser() {
        if !UserDefaultService.hasLaunched {
            //show onboarding
            let vc = PageControlDescription()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    private func passData() {
        mainProgressView.sugarProgress.animate(value: Float(sugarLeft), total: Float(sugarIntake))
        mainProgressView.satFatProgress.animate(value: Float(satFatLeft), total: Float(saturatedFatIntake))
        mainProgressView.calorieProgress.animate(value: Float(calorieLeft), total: Float(calorieIntake))
        
        mainProgressView.setupView(
            totalCalorie: Float(calorieIntake),
            totalSatFat: Float(saturatedFatIntake),
            satFatLeftAmount: Float(satFatLeft),
            totalSugar: Float(sugarIntake),
            sugarLeftAmount: Float(sugarLeft))
    }
    
    private func countCalorie() {
        if UserDefaultService.gender == "Male" {
            calorieIntake = (10 * weight!) + (6.25 * height!) - (5 * age!) + 5
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        }
        if UserDefaultService.gender == "Female" {
            calorieIntake = (10 * weight!) + (6.25 * height!) - (5 * age!) - 161
            saturatedFatIntake = (calorieIntake / 10) / 9
            sugarIntake = (calorieIntake / 10) / 4
        }
    }
    
    private func fetchData() {
        if HealthKitService.shared.checkAuthorization() {
            HealthKitService.shared.fetchCalorie { (totalCal) in
                self.calorieLeft = self.calorieIntake - totalCal
            }
            HealthKitService.shared.fetchSaturatedFat { (totalFat) in
                self.satFatLeft = self.saturatedFatIntake - totalFat
            }
            HealthKitService.shared.fetchSugar { (totalSugar) in
                self.sugarLeft = self.sugarIntake - totalSugar
            }
            HealthKitService.shared.fetchWater { (water) in
                self.totalWater = water
            }
            HealthKitService.shared.fetchActivity { (step) in
                self.totalStep = step
            }
        } else {
            CoreDataService.shared.getDailyIntake { (intakes) in
                let calorie = intakes.map { $0.calorie }
                let satFat = intakes.map { $0.saturatedFat }
                let sugar = intakes.map { $0.sugars }
                
                self.calorieLeft = self.calorieIntake - calorie.reduce(0.0, +)
                self.satFatLeft = self.saturatedFatIntake - satFat.reduce(0.0, +)
                self.sugarLeft = self.sugarIntake - sugar.reduce(0.0, +)
            }
        }
    }
      
    @objc private func handleWater(sender: UITapGestureRecognizer) {
        let vc =  WaterViewController()
        vc.delegate = self
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func handleActivity(sender: UITapGestureRecognizer) {
        let activity = ActivityCard()
        activity.delegate = self
        navigationController?.present(UINavigationController(rootViewController: ActivityViewController()), animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
  

// MARK: Setup View
extension MainViewController : GetDataDelegate , GetDataActivityDelegate {
    
    func sendStep(steps: Int) {
        activityCardView.setupViewActivity(amount: steps)
    }
    func sendWater(water: Int) {
        waterCardView.setupViewWater(amount: water)
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
        mainProgressView.rootView = self
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
            detailText: "💧 0 cups remaining",
            iconImage: UIImage(),
            background: Color.blue)
        let tapWater = UITapGestureRecognizer(target: self, action: #selector(handleWater(sender:)))
        waterCardView.addGestureRecognizer(tapWater)
        waterCardView.setConstraint(heighAnchorConstant: 46)
       
        activityCardView = HorizontalView(
            labelText: "Activity",
            detailText: "🔥 \(Int(self.totalStep)) Step",
            iconImage: UIImage(),
            background: Color.red)
        activityCardView.setConstraint(heighAnchorConstant: 46)
        let tapActivity = UITapGestureRecognizer(target: self, action: #selector(handleActivity(sender:)))
        activityCardView.addGestureRecognizer(tapActivity)
        
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
