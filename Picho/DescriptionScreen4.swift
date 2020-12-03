//
//  Screen1ViewController.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 09/11/20.
//

import UIKit

class DescriptionScreen4: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phoneWidth = UIScreen.main.bounds.maxX

        view.backgroundColor = Color.background
        
        let image = UIImage(named: "4")
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.setConstraint(
            centerXAnchor: view.centerXAnchor,
            centerYAnchor: view.centerYAnchor, centerYAnchorConstant: -124,
            heighAnchorConstant: phoneWidth, widthAnchorConstant: phoneWidth)
        
        let label1 = UILabel()
        label1.text = NSLocalizedString("Enjoy what you eat\nEat what you enjoy!", comment: "")
        label1.textAlignment = .center
        label1.numberOfLines = 0
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)

        view.addSubview(label1)
        label1.setConstraint(
            topAnchor: imageview.bottomAnchor, topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        let label2 = UILabel()
        label2.text = NSLocalizedString("Picho is help you to eat what you love while being aware of your food consumption and cholesterol.", comment: "")
        label2.textAlignment = .center
        label2.numberOfLines = 0
        view.addSubview(label2)
        label2.setConstraint(
            topAnchor: label1.bottomAnchor, topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 20,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -20)
        
        
        let getStartedBtn = UIButton()
        getStartedBtn.setTitle(NSLocalizedString("Get Started", comment: ""), for: .normal)
        getStartedBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getStartedBtn.layer.cornerRadius =  10
        getStartedBtn.backgroundColor = Color.green
        view.addSubview(getStartedBtn)
        getStartedBtn.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
        
        getStartedBtn.addTarget(self, action: #selector(handleStarted), for: .touchUpInside)
    }
    
    @objc func handleStarted() {
        let vc = PageControlForm()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

