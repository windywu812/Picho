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
    private var pichoCardView: PichoCardView?
    private var waterCardView: HorizontalView!
    private var activityCardView: HorizontalView!
    private var activityStack: UIStackView!
    private var mealTodayView: MealsTodayView!
    private var cancellables: Set<AnyCancellable> = []
    
    private let viewModel = JournalViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchData()
        setupProgressView()
        setupActivity()
        setupMealTodayView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScrollView()
        setupMainProgress()
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
    
    private func setupScrollView() {
        navigationItem.title = NSLocalizedString("Today", comment: "")
        
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
    
    private func setupPicho() {
        
        if Date() < Date().getBreakfast().date! {
            pichoCardView = PichoCardView(
                mascot: "mascot_sad",
                title: NSLocalizedString("Morning", comment: ""),
                detail: NSLocalizedString("Hope you've had a good night's sleep", comment: "") ,
                buttonText: NSLocalizedString("Log Breakfast", comment: "") ,
                type: .breakfast, rootView: self)
        } else if Date() > Date().getBreakfast().date! && Date() < Date().getLunch().date! {
            if !UserDefaultService.hasBreakfast {
                pichoCardView = PichoCardView(
                    mascot: "mascot_sad",
                    title: NSLocalizedString("You haven't started!", comment: "") ,
                    detail: NSLocalizedString("Start by logging in what you eat today", comment: "") ,
                    buttonText: NSLocalizedString("Log Breakfast", comment: "") ,
                    type: .breakfast, rootView: self)
            } else {
                pichoCardView = nil
            }
        }else if Date() > Date().beforeLunch().date! && Date() < Date().getLunch().date!  {
            if !UserDefaultService.hasLunch {
                pichoCardView = PichoCardView(
                    mascot: "mascot_detail",
                    title: "Did you know...",
                    detail: "That there are three different kind of fats?",
                    buttonText: "Read More",
                    type: .detail, rootView: self)
            } else {
                pichoCardView = nil
            }
        }  else if Date() > Date().getLunch().date! && Date() < Date().getWater().date!  {
            if !UserDefaultService.hasLunch {
                pichoCardView = PichoCardView(
                    mascot: "mascot_lunch",
                    title: "Lunchie!",
                    detail: "Psst.. I heard lunch is a great place to be",
                    buttonText: "Log Lunch",
                    type: .lunch, rootView: self)
            } else {
                pichoCardView = nil
            }
        }else if Date() > Date().getDinner().date! {
            if !UserDefaultService.hasLunch {
                pichoCardView = PichoCardView(
                    mascot: "mascot_water",
                    title: "Gulp gulp",
                    detail: "Our body in average is made up of 60% water. So drink up!",
                    buttonText: "Log Water",
                    type: .water, rootView: self)
            } else {
                pichoCardView = nil
            }
        }  else if Date() > Date().getDinner().date! {
            if !UserDefaultService.hasDinner {
                pichoCardView = PichoCardView(
                    mascot: "mascot_sad",
                    title:  NSLocalizedString("Din din!", comment: "") ,
                    detail: NSLocalizedString("What a day it has been, don't forget to log your dinner", comment: "") ,
                    buttonText: NSLocalizedString("Log Dinner", comment: "") ,
                    type: .dinner, rootView: self)
            } else {
                pichoCardView = nil
            }
        } else if Date() > Date().getSnack().date! && Date() < Date().getDinner().date!  {
            if !UserDefaultService.hasLunch {
                pichoCardView = PichoCardView(
                    mascot: "mascot_snack",
                    title: "*Crunch*",
                    detail: "Healthy snacks keep the doctors away!",
                    buttonText: "Log Snack",
                    type: .snack, rootView: self)
            } else {
                pichoCardView = nil
            }
        } else if Date() > Date().getSleep().date! && Date() < Date().getBreakfast().date!  {
            if !UserDefaultService.hasDinner {
                pichoCardView = PichoCardView(
                    mascot: "mascot_sleep",
                    title: "*Yawns*",
                    detail: "Time to turn off the lights and prepare for tomorrow!",
                    buttonText: "",
                    type: .snack, rootView: self)
            } else {
                pichoCardView = nil
            }
        }
        
        
    }
    
    private func setupActivity() {
        
        if activityStack != nil { activityStack.removeFromSuperview() }
        
        setupPicho()
        
        waterCardView = HorizontalView(
            labelText: NSLocalizedString("Water", comment: "") ,
            iconImage: UIImage(),
            background: Color.blue)
        let tapWater = UITapGestureRecognizer(target: self, action: #selector(handleWater(sender:)))
        waterCardView.addGestureRecognizer(tapWater)
        
        activityCardView = HorizontalView(
            labelText: NSLocalizedString("Activity", comment: "") ,
            iconImage: UIImage(),
            background: Color.red)
        let tapActivity = UITapGestureRecognizer(target: self, action: #selector(handleActivity(sender:)))
        activityCardView.addGestureRecognizer(tapActivity)
        
        activityStack = UIStackView(arrangedSubviews: [pichoCardView, waterCardView, activityCardView].compactMap({ $0 }))
        activityStack.spacing = 16
        activityStack.axis = .vertical
        scrollView.addSubview(activityStack)
        
        activityStack.setConstraint(
            topAnchor: mainProgressView.bottomAnchor, topAnchorConstant: 24,
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
    
    @objc private func handleWater(sender: UITapGestureRecognizer) {
        let vc =  WaterViewController()
        vc.delegate = self
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    @objc private func handleActivity(sender: UITapGestureRecognizer) {
        let vc = ActivityViewController()
        vc.viewModel = viewModel
        navigationController?.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

extension JournalViewController: WaterDelegate {
    func sendWater(water: Int) {
        waterCardView.setupView(amount: water, type: .water)
    }
}
