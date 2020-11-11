//
//  Screen1ViewController.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 09/11/20.
//

import UIKit

class DescriptionScreen3: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let image = UIImage(named: "3")
        
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageview.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -100).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 275).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        let label1 = UILabel()
        label1.text = "Too much ‘bad’\nCholesterol in your body..."
        label1.textAlignment = .center
        label1.numberOfLines = 0
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        label1.textAlignment = .center

        view.addSubview(label1)
        label1.setConstraint(topAnchor: imageview.bottomAnchor,topAnchorConstant: 20,
                                leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
                                trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        let label2 = UILabel()
        label2.text = "can form plaque on the arteries, making the passage smaller, leading to high blood pressure (HBP), heart diseases and stroke."
        label2.textAlignment = .center
        label2.numberOfLines = 0
        label2.font = UIFont.systemFont(ofSize: 17)
        view.addSubview(label2)
        label2.setConstraint(topAnchor: label1.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 20,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -20)
        
    }
}

