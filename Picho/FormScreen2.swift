//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen2: UIViewController {
    
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let nameTextField = UITextField()
    let getStartedBtn = UIButton()
   
    var rootView: PageControlForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.background
        
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.image = UIImage(named: "mascot")
        view.addSubview(imageview)
        
        imageview.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 80,
            centerXAnchor: view.centerXAnchor,
            heighAnchorConstant: 115, widthAnchorConstant: 95)
        
        titleLabel.text = "Nice to meet you!"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.setConstraint(
            topAnchor: imageview.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        descLabel.text = "Picho will be your buddy throughout this journey, tell him your name so you can get to know each other!"
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        view.addSubview(descLabel)
        
        descLabel.setConstraint(
            topAnchor: titleLabel.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -16)
        
        nameTextField.layer.cornerRadius = 6
        nameTextField.layer.borderColor = Color.green.cgColor
        nameTextField.layer.borderWidth = 2.0
        nameTextField.addPadding(padding: .equalSpacing(10))
        nameTextField.placeholder = "Your Name"
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        nameTextField.setConstraint(
            topAnchor: descLabel.bottomAnchor, topAnchorConstant: 50,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
        
        getStartedBtn.setTitle("Continue", for: .normal)
        getStartedBtn.layer.cornerRadius =  6
        getStartedBtn.backgroundColor = Color.lightGreen
        getStartedBtn.tintColor = Color.green
        getStartedBtn.isEnabled = false
        view.addSubview(getStartedBtn)
        
        getStartedBtn.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
        
        getStartedBtn.addTarget(self, action: #selector(handleSaveName), for: .touchUpInside)
        
    }
     
    @objc func handleSaveName() {
        UserDefaultService.name = nameTextField.text!
        rootView?.setView(index: 2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension FormScreen2: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.isEmpty {
            getStartedBtn.backgroundColor = Color.lightGreen
            getStartedBtn.tintColor = Color.green
            getStartedBtn.isEnabled = false
        } else {
            getStartedBtn.backgroundColor = Color.green
            getStartedBtn.tintColor = .white
            getStartedBtn.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
