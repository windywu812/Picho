//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen2: UIViewController {
    
    let label1 = UILabel()
    let label2 = UILabel()
    let nameTextField = UITextField()
    let getStartedBtn = UIButton()
   
    var rootViewS2 : PageControlForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
 
    func setupView() {
        view.backgroundColor = .white
        
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
        
        label1.text = "Nice to meet you!"
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        label1.textAlignment = .center
        view.addSubview(label1)
        label1.setConstraint(topAnchor: imageview.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 40,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -40)
        
        
        label2.text = "Picho will be your buddy throughout this journey, tell him your name so you can get to know each other!"
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.numberOfLines = 0
        label2.textAlignment = .center
        view.addSubview(label2)
        label2.setConstraint(topAnchor: label1.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 40,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -40)
        
        
        nameTextField.layer.cornerRadius = 10.0
        nameTextField.layer.borderColor = Color.green.cgColor
        nameTextField.layer.borderWidth = 2.0
        nameTextField.addPadding(padding: .equalSpacing(10))
        nameTextField.placeholder = "Your Name"
        view.addSubview(nameTextField)
        nameTextField.setConstraint(topAnchor: label2.bottomAnchor,topAnchorConstant: 50,centerXAnchor: view.centerXAnchor,heighAnchorConstant: 50, widthAnchorConstant: 299)
        
        
        getStartedBtn.setTitle("Continue", for: .normal)
        getStartedBtn.layer.cornerRadius =  5
        getStartedBtn.backgroundColor = Color.green
        view.addSubview(getStartedBtn)
        getStartedBtn.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtn.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        getStartedBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getStartedBtn.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        getStartedBtn.addTarget(self, action: #selector(handleSaveName), for: .touchUpInside)
        
        
    }
    @objc func handleSaveName(){
        UserDefaultService.firstName = nameTextField.text!
     
        rootViewS2?.setView(index: 2)
    }
}
