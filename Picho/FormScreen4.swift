//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen4: UIViewController {
    
    let weightTextField = UITextField()
    let heightTextField = UITextField()
    var getStartedBtn: UIButton!
    var rootView : PageControlForm?
    
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
        
        let titleLabel = UILabel()
        titleLabel.text = "Can you tell me about your current weight and height?"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.addSubview(titleLabel)
        
        titleLabel.setConstraint(
            topAnchor: imageview.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 0,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: 0)
        
        let descLabel = UILabel()
        descLabel.text = "To get better estimation for you calorie needs, Picho also need your weight and height..."
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        view.addSubview(descLabel)
        
        descLabel.setConstraint(
            topAnchor: titleLabel.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 0,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: 0)
        
        let weightLabel = UILabel()
        weightLabel.setFont(text: "Weight(KG)", size: 16, weight: .bold)
        
        weightTextField.layer.cornerRadius = 6
        weightTextField.placeholder = "Weight"
        weightTextField.layer.borderColor = Color.green.cgColor
        weightTextField.layer.borderWidth = 2.0
        weightTextField.setConstraint(heighAnchorConstant: 50)
        weightTextField.addPadding(padding: .equalSpacing(10))
        weightTextField.keyboardType = .numberPad
        weightTextField.delegate = self
        weightTextField.tag = 0
        
        let stackWeight = UIStackView(arrangedSubviews: [weightLabel, weightTextField])
        stackWeight.axis = .vertical
        stackWeight.spacing = 16
        
        view.addSubview(stackWeight)
        stackWeight.setConstraint(
            topAnchor: descLabel.bottomAnchor, topAnchorConstant: 50,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16)
        weightTextField.setConstraint(heighAnchorConstant: 50)
        
        let heightLabel = UILabel()
        heightLabel.setFont(text: "Height(CM)", size: 16, weight: .bold, color: .black)
        
        heightTextField.addPadding(padding: .equalSpacing(10))
        heightTextField.layer.cornerRadius = 6
        heightTextField.layer.borderColor = Color.green.cgColor
        heightTextField.layer.borderWidth = 2.0
        heightTextField.placeholder = "Height"
        heightTextField.delegate = self
        heightTextField.tag = 1
        heightTextField.keyboardType = .numberPad
        heightTextField.setConstraint(heighAnchorConstant: 50)
        
        let stackHeight = UIStackView(arrangedSubviews: [heightLabel, heightTextField])
        stackHeight.axis = .vertical
        stackHeight.spacing = 16
        view.addSubview(stackHeight)
        
        stackHeight.setConstraint(
            topAnchor: stackWeight.bottomAnchor, topAnchorConstant: 36,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16)
        
        heightTextField.setConstraint(heighAnchorConstant: 50)
        
        getStartedBtn = UIButton()
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
        
        getStartedBtn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    
    @objc func handleSave(){
        UserDefaultService.height = heightTextField.text!
        UserDefaultService.weight = weightTextField.text!
        
        rootView?.setView(index: 4)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    var height = ""
    var weight = ""
    
}

extension FormScreen4: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
                
        if textField.tag == 0 {
            weight = textField.text ?? ""
        } else {
            height = textField.text ?? ""
        }
         
        if !height.isEmpty && !weight.isEmpty {
            getStartedBtn.backgroundColor = Color.green
            getStartedBtn.tintColor = .white
            getStartedBtn.isEnabled = true
        } else {
            getStartedBtn.backgroundColor = Color.lightGreen
            getStartedBtn.tintColor = Color.green
            getStartedBtn.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
