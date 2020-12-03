//
//  Screen1ViewController.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 09/11/20.
//

import UIKit

class DescriptionScreen2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.background
        
        let phoneWidth = UIScreen.main.bounds.maxX

        let image = UIImage(named: "2")
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.setConstraint(
            centerXAnchor: view.centerXAnchor,
            centerYAnchor: view.centerYAnchor, centerYAnchorConstant: -124,
            heighAnchorConstant: phoneWidth,
            widthAnchorConstant: phoneWidth)
        
        let label1 = UILabel()
        label1.text = NSLocalizedString("Health requires healthy\nfood",comment: "")
        label1.textAlignment = .center
        label1.numberOfLines = 0
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.addSubview(label1)
        label1.setConstraint(
            topAnchor: imageview.bottomAnchor,topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        let label2 = UILabel()
        label2.text = NSLocalizedString("We get the ‘good’ cholesterol (HDL) from healthy and balanced diet.\n\nAnd the ‘bad’ (LDL) ones from unhealthy and unbalanced diet.", comment: "") 
        label2.textAlignment = .center
        label2.numberOfLines = 0
        view.addSubview(label2)
        label2.setConstraint(
            topAnchor: label1.bottomAnchor, topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 20,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -20)
        
    }
}

