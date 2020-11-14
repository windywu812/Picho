//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen3: UIViewController {
    
    let genders = ["Male", "Female"]
    let genderTextField = UITextField()
    let ageTextField = UITextField()
    let pickerView = UIPickerView()
    var getStartedBtn = UIButton()
    var rootView : PageControlForm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickGender()
        setupView()
    }
    
    func pickGender() {
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 0, inComponent: 0)
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTextField.inputView = pickerView
    }
    
    func setupView() {
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
        titleLabel.text = "I want to know more about you."
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)
        
        titleLabel.setConstraint(
            topAnchor: imageview.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        let descLabel = UILabel()
        descLabel.text = "Different age and gender have different calories needs, also fat and sugar intake. Tell Picho yours so he can help you calculate!"
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        view.addSubview(descLabel)
        
        descLabel.setConstraint(
            topAnchor: titleLabel.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -16)
        
        genderTextField.layer.cornerRadius = 6
        genderTextField.placeholder = "Gender"
        genderTextField.layer.borderColor = Color.green.cgColor
        genderTextField.layer.borderWidth = 2.0
        genderTextField.addPadding(padding: .equalSpacing(10))
        genderTextField.delegate = self
        genderTextField.tag = 0
        view.addSubview(genderTextField)
        
        genderTextField.setConstraint(
            topAnchor: descLabel.bottomAnchor, topAnchorConstant: 50,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
        
        ageTextField.addPadding(padding: .equalSpacing(10))
        ageTextField.layer.cornerRadius = 6
        ageTextField.layer.borderColor = Color.green.cgColor
        ageTextField.layer.borderWidth = 2.0
        ageTextField.placeholder = "Age"
        ageTextField.delegate = self
        ageTextField.keyboardType = .numberPad
        ageTextField.tag = 1
        view.addSubview(ageTextField)
        
        ageTextField.setConstraint(
            topAnchor: genderTextField.bottomAnchor, topAnchorConstant: 36,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
        
        getStartedBtn = UIButton()
        getStartedBtn.setTitle("Continue", for: .normal)
        getStartedBtn.layer.cornerRadius =  5
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
    
    @objc func handleSave() {
        UserDefaultService.gender = genderTextField.text!
        UserDefaultService.age = ageTextField.text!
        
        rootView?.setView(index: 3)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var gender: String = ""
    var age: String = ""
    
}

extension FormScreen3 :  UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
    }
    
    
    
}

extension FormScreen3: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
                
        if textField.tag == 0 {
            gender = textField.text ?? ""
        } else {
            age = textField.text ?? ""
        }
         
        print(gender, age)
        
        if !gender.isEmpty && !age.isEmpty {
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
