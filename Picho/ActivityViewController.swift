//
//  ActivityViewController.swift
//  Picho
//
//  Created by Windy on 11/11/20.
//

import UIKit

class ActivityViewController: UIViewController {
    
    let detailText = """
    By losing fat and building muscles, you can increase your ‘good’ HDL (high-density lipoprotein) cholesterol  while decreasing your ‘bad’ LDL (low-density lipoprotein) cholesterol at the same time! That’s just killing two birds with one stone, right?  Picho can help you track your burned calories and adjust your daily intake better when linked to Health.
    """
    
    private var descriptionLabel: UILabel!
    private var cardView: PichoCardView!
    private var activityCard: ActivityCard!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Activity"
        
        setupView()
        setupLayout()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(handleClose))
        
    }
  
        
    
    
    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        view.backgroundColor = Color.background
        
        descriptionLabel = UILabel()
        descriptionLabel.text = detailText
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)
        
        cardView = PichoCardView(mascot: "mascot", title: "Activity \"Health\"", detail: "For better result, connect Picho to Apple Health", buttonText: "Connect to ❤️", rootView: self)
        view.addSubview(cardView)
        
        activityCard = ActivityCard()
        view.addSubview(activityCard)
    }
    
    private func setupLayout() {
        descriptionLabel.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        cardView.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -64,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 130)
        
        activityCard.setConstraint(
            bottomAnchor: cardView.topAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 50)
    }
    
}

class ActivityCard: UIView {
    
    private var activityLabel: UILabel!
    private var amountLabel: UILabel!
    private var totalStep : Double = 0.0
    var activity: Double = 0 {
        didSet { amountLabel.text = "\(activity)" }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.red
        layer.cornerRadius = 8
        
        activityLabel = UILabel()
        HealthKitService.shared.fetchActivity { (step) in
            self.totalStep = step
            DispatchQueue.main.async{[self] in
                amountLabel.text = "🔥 \(Int(totalStep)) Step"
            }
        }
        activityLabel.setFont(text: "Activity", weight: .bold, color: .white)
        amountLabel = UILabel()
        
        self.amountLabel.setFont(text: "🔥 \(Int(totalStep)) Step", weight: .bold, color: .white)
        
        
        let activityStack = UIStackView(arrangedSubviews: [activityLabel, amountLabel])
        activityStack.axis = .horizontal
        activityStack.distribution = .equalCentering
        addSubview(activityStack)
        
        activityStack.setConstraint(
            leadingAnchor: layoutMarginsGuide.leadingAnchor, 
            trailingAnchor: layoutMarginsGuide.trailingAnchor,
            centerYAnchor: centerYAnchor)
    }
  
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
