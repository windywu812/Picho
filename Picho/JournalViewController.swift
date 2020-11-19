//
//  ViewController.swift
//  iChol
//
//  Created by Muhammad Rasyid khaikal on 02/11/20.
//
import UIKit
import HealthKit
import Combine

class JournalViewController: UIViewController {
    
    private var scrollView: UIScrollView!
    private var mainProgressView: MainProgressView!
    private var pichoCardView: PichoCardView!
    private var waterCardView: HorizontalView!
    private var activityCardView: HorizontalView!
    private var activityStack: UIStackView!
    private var mealTodayView: MealsTodayView!
    private var cancellables: Set<AnyCancellable> = []
    
    let viewModel = JournalViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
 
        viewModel.fetchData()
        setupProgressView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today"
        
        viewModel.checkUser(view: self)
        setupScrollView()
        setupMainProgress()
        setupPichoCard()
        setupActivity()
        setupMealTodayView()
        bindViewModel()
    }
    
    private func setupProgressView() {
        mainProgressView.setupView(
            totalCalorie: Float(viewModel.calorieIntake),
            totalSatFat: Float(viewModel.saturatedFatIntake),
            satFatLeftAmount: Float(viewModel.satFatLeft),
            totalSugar: Float(viewModel.sugarIntake),
            sugarLeftAmount: Float(viewModel.sugarLeft))
    }
    
    private func bindViewModel() {
        viewModel.$calorieLeft
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                self.mainProgressView.calorieProgress.animate(value: Float(value), total: Float(self.viewModel.calorieIntake))
            }
            .store(in: &cancellables)
        
        viewModel.$satFatLeft
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                self.mainProgressView.satFatProgress.animate(value: Float(value), total: Float(self.viewModel.saturatedFatIntake))
            }
            .store(in: &cancellables)
        
        viewModel.$sugarLeft
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                self.mainProgressView.sugarProgress.animate(value: Float(value), total: Float(self.viewModel.sugarIntake))
            }
            .store(in: &cancellables)
        
        viewModel.$totalWater
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                self.waterCardView.setupView(amount: Int(value), type: .water)
            }
            .store(in: &cancellables)
        
        viewModel.$totalStep
            .receive(on: DispatchQueue.main)
            .sink { (value) in
                self.activityCardView.setupView(amount: Int(value), type: .activity)
            }
            .store(in: &cancellables)
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
        mainProgressView = MainProgressView(rootView: self, viewModel: viewModel)
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
            detailText: "🔥 \(Int(viewModel.totalStep)) Step",
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
  

extension JournalViewController: GetDataDelegate , GetDataActivityDelegate {
    
    func sendStep(steps: Int) {
        activityCardView.setupView(amount: steps, type: .activity)
    }
    func sendWater(water: Int) {
        waterCardView.setupView(amount: water, type: .water)
    }
    
}
