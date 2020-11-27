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
        
        let phoneWidth = UIScreen.main.bounds.maxX
        
        view.backgroundColor = Color.background
        
        let image = UIImage(named: "2")
        
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageview.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -124).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: phoneWidth).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: phoneWidth).isActive = true
        
        let label1 = UILabel()
        label1.text = "Health requires healthy\nfood"
        label1.textAlignment = .center
        label1.numberOfLines = 0
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        label1.textAlignment = .center

        view.addSubview(label1)
        label1.setConstraint(topAnchor: imageview.bottomAnchor,topAnchorConstant: 20,
                                leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        let label2 = UILabel()
        label2.text = "We get the ‘good’ cholesterol (HDL) from healthy and balanced diet.\n\nAnd the ‘bad’ (LDL) ones from unhealthy and unbalanced diet."
        label2.textAlignment = .center
        label2.numberOfLines = 0
        label2.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(label2)
        label2.setConstraint(topAnchor: label1.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 20,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -20)
        
    }
}

