//
//  InfoDetailViewController.swift
//  Picho
//
//  Created by Windy on 12/11/20.
//

import UIKit

class InfoDetailViewController: UIViewController {
    
    private var progressView: TopProgressView!
    private var detailLabel: UILabel!
    private let detailText = """
    Saturated fat and sugar can trigger increase in ‘bad’ cholesterol (LDL). When sugar level is high, excess sugar gets converted to triglycerides.

    High triglycerides cause hardening on the arteries' wall (atherosclerosis). Along with ‘bad’ cholesterol (LDL), they increase the risk of stroke, heart attack and heart disease.
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        navigationItem.title = "Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        
        progressView = TopProgressView()
        view.addSubview(progressView)
        view.backgroundColor = Color.background
        
        progressView.calorieProgress.animate(value: 454, total: 2000)
        progressView.satFatProgress.animate(value: 12, total: 25)
        progressView.sugarProgress.animate(value: 32, total: 36)
        
        detailLabel = UILabel()
        detailLabel.setFont(text: detailText)
        detailLabel.numberOfLines = 0
        view.addSubview(detailLabel)
    }
    
    private func setupLayout() {
        progressView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 320)
        
        detailLabel.setConstraint(
            topAnchor: progressView.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    @objc private func handleDone() {
        dismiss(animated: true, completion: nil)
    }
    
}

class TopProgressView: UIView {
    
    private var calorieLabel: UILabel!
    private var calorieTotalLabel: UILabel!
    var calorieProgress: CircularProgressView!
    
    private var satFatLabel: UILabel!
    private var satFatLeft: UILabel!
    private var satFatTotalLabel: UILabel!
    var satFatProgress: SmallCircularProgressView!
    
    private var sugarLabel: UILabel!
    private var sugarLeft: UILabel!
    private var sugarTotalLabel: UILabel!
    var sugarProgress: SmallCircularProgressView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupView()
        setupLayout()
        
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    private func setupView() {
        calorieProgress = CircularProgressView()
        calorieLabel = UILabel()
        calorieTotalLabel = UILabel()
        calorieLabel.setFont(text: "CALORIES", weight: .bold)
        calorieTotalLabel.setFont(text: "2000 cal", size: 13)
        addSubview(calorieProgress)
        
        satFatProgress = SmallCircularProgressView()
        satFatLabel = UILabel()
        satFatLeft = UILabel()
        satFatTotalLabel = UILabel()
        satFatLabel.setFont(text: "SATURATED FAT", size: 13, weight: .bold)
        satFatLeft.setFont(text: "15g left", size: 13, weight: .bold)
        satFatTotalLabel.setFont(text: "from 25g/day", size: 13, color: .secondaryLabel)
        addSubview(satFatProgress)
        
        sugarProgress = SmallCircularProgressView()
        sugarLabel = UILabel()
        sugarLeft = UILabel()
        sugarTotalLabel = UILabel()
        sugarLabel.setFont(text: "SUGAR", size: 13, weight: .bold)
        sugarLeft.setFont(text: "5g left", size: 13, weight: .bold)
        sugarTotalLabel.setFont(text: "from 36g/day", size: 13, color: .secondaryLabel)
        addSubview(sugarProgress)
        
        addSubview(satFatLabel)
        addSubview(sugarLabel)
    }
    
    private func setupLayout() {
        sugarProgress.setConstraint(
            heighAnchorConstant: 50, widthAnchorConstant: 50)
        satFatProgress.setConstraint(
            heighAnchorConstant: 50, widthAnchorConstant: 50)
        
        let calorieStack = UIStackView(arrangedSubviews: [calorieLabel, calorieTotalLabel])
        calorieStack.axis = .vertical
        calorieStack.spacing = 8
        addSubview(calorieStack)
        
        calorieStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16)
        calorieProgress.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 64,
            centerXAnchor: centerXAnchor,
            heighAnchorConstant: 100, widthAnchorConstant: 100)
        
        let divider = UIView()
        divider.backgroundColor = .secondaryLabel
        addSubview(divider)
        divider.setConstraint(
            topAnchor: calorieProgress.bottomAnchor, topAnchorConstant: 36,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 1)
        
        let satFatVStack = UIStackView(arrangedSubviews: [satFatLeft, satFatTotalLabel])
        satFatVStack.spacing = 4
        satFatVStack.alignment = .leading
        satFatVStack.axis = .vertical
        
        let satFatHStack = UIStackView(arrangedSubviews: [satFatProgress, satFatVStack])
        satFatHStack.spacing = 4
        satFatHStack.alignment = .center
        satFatHStack.axis = .horizontal
        addSubview(satFatHStack)
      
        satFatLabel.setConstraint(
            topAnchor: divider.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16)
        
        satFatHStack.setConstraint(
            topAnchor: satFatLabel.bottomAnchor, topAnchorConstant: 4,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16)
        
        let middle = UIView()
        addSubview(middle)
        middle.setConstraint(
            topAnchor: topAnchor,
            bottomAnchor: bottomAnchor,
            centerXAnchor: centerXAnchor,
            widthAnchorConstant: 1)
        
        let sugarVStack = UIStackView(arrangedSubviews: [sugarLeft, sugarTotalLabel])
        sugarVStack.spacing = 4
        sugarVStack.alignment = .leading
        sugarVStack.axis = .vertical
        
        let sugarHStack = UIStackView(arrangedSubviews: [sugarProgress, sugarVStack])
        sugarHStack.spacing = 4
        sugarHStack.alignment = .center
        sugarHStack.axis = .horizontal
        addSubview(sugarHStack)
      
        sugarLabel.setConstraint(
            topAnchor: divider.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: middle.trailingAnchor)
        
        sugarHStack.setConstraint(
            topAnchor: sugarLabel.bottomAnchor, topAnchorConstant: 4,
            leadingAnchor: middle.trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
