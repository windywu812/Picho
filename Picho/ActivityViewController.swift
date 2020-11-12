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
    }
    
}
