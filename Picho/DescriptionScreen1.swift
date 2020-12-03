//
//  Screen1ViewController.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 09/11/20.
//

import UIKit

class DescriptionScreen1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let phoneWidth = UIScreen.main.bounds.maxX
        
        view.backgroundColor = Color.background
        
        let image = UIImage(named: "1")
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        
        imageview.setConstraint(
            centerXAnchor: view.centerXAnchor,
            centerYAnchor: view.centerYAnchor, centerYAnchorConstant: -124,
            heighAnchorConstant: phoneWidth, widthAnchorConstant: phoneWidth)
        
        let label1 = UILabel()
        label1.text =  NSLocalizedString("Hi there!!" , comment: "")
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.addSubview(label1)
        
        label1.setConstraint(
            topAnchor: imageview.bottomAnchor, topAnchorConstant: 20,
            centerXAnchor: view.centerXAnchor)
     
        let label2 = UILabel()
        label2.text = NSLocalizedString("I’m Picho, a pistachio. And I contain  ‘good’ cholesterol for your body!\n\nBut! Do you know that ‘bad’ cholesterol also exist?", comment: "")
            
        label2.textAlignment = .center
        label2.numberOfLines = 0
        label2.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(label2)
        label2.setConstraint(
            topAnchor: label1.bottomAnchor, topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 20,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -20)
    }
    
}
