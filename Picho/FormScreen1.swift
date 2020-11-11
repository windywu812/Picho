//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen1: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.background
        
        let image = UIImage(named: "mascot")
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageview.topAnchor.constraint(equalTo: view.topAnchor,constant: 100).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 95).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        let label1 = UILabel()
        label1.text = "Picho is here to help!"
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.addSubview(label1)
  
        label1.setConstraint(topAnchor: imageview.bottomAnchor,topAnchorConstant: 20,
                                leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 51,
                                trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: 51)
       
        
      
        
        
        let label2 = UILabel()
        label2.text = "Picho needs the following information to help you with your recommended daily intake of calorie, saturated fat and sugar."
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.numberOfLines = 0
        label2.textAlignment = .center
        
        view.addSubview(label2)
        label2.setConstraint(topAnchor: label1.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 40,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -40)
        
       
        
        let getStartedBtn = UIButton()
        getStartedBtn.setTitle("Hi Picho", for: .normal)
        getStartedBtn.layer.cornerRadius =  5
        getStartedBtn.backgroundColor = Color.green
        view.addSubview(getStartedBtn)
        getStartedBtn.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtn.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        getStartedBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getStartedBtn.widthAnchor.constraint(equalToConstant: 270).isActive = true
    }
}