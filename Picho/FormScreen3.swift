//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen3: UIViewController {
    
    var gender = ["Male","Female"]
    let genderTextField = UITextField()
    let ageTextField = UITextField()
    let pickerView = UIPickerView()
    var rootViewS3 : PageControlForm?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickGender()
        setupView()
        
    }
    
    func pickGender(){
        pickerView.delegate?.pickerView?(pickerView, didSelectRow: 0, inComponent: 0)
        pickerView.delegate = self
        pickerView.dataSource = self
        genderTextField.inputView = pickerView
    }
    
    func setupView(){
        view.backgroundColor = .white
        
        let image = UIImage(named: "mascot")
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 95).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        let label1 = UILabel()
        label1.text = "I want to know more about you."
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        label1.textAlignment = .center
        label1.numberOfLines = 0
        view.addSubview(label1)
        label1.setConstraint(topAnchor: imageview.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 30,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -30)
        
        let label2 = UILabel()
        label2.text = "Different age and gender have different calories needs, also fat and sugar intake. Tell Picho yours so he can help you calculate!"
        label2.font = UIFont.systemFont(ofSize: 17)
        label2.numberOfLines = 0
        label2.textAlignment = .center
        view.addSubview(label2)
        label2.setConstraint(topAnchor: label1.bottomAnchor,topAnchorConstant: 20,
                             leadingAnchor: view.layoutMarginsGuide.leadingAnchor,leadingAnchorConstant: 40,
                             trailingAnchor: view.layoutMarginsGuide.trailingAnchor,trailingAnchorConstant: -40)
        
        genderTextField.layer.cornerRadius = 10.0
        genderTextField.placeholder = "Gender"
        genderTextField.layer.borderColor = Color.green.cgColor
        genderTextField.layer.borderWidth = 2.0
        genderTextField.addPadding(padding: .equalSpacing(10))
        view.addSubview(genderTextField)
        genderTextField.setConstraint(topAnchor: label2.bottomAnchor,topAnchorConstant: 50,centerXAnchor: view.centerXAnchor,heighAnchorConstant: 50, widthAnchorConstant: 299)
        
       
        ageTextField.addPadding(padding: .equalSpacing(10))
        ageTextField.layer.cornerRadius = 10.0
        ageTextField.layer.borderColor = Color.green.cgColor
        ageTextField.layer.borderWidth = 2.0
        ageTextField.placeholder = "Age"
        view.addSubview(ageTextField)
        ageTextField.setConstraint(topAnchor: genderTextField.bottomAnchor,topAnchorConstant: 50,centerXAnchor: view.centerXAnchor,heighAnchorConstant: 50, widthAnchorConstant: 299)
        
        let getStartedBtn = UIButton()
        getStartedBtn.setTitle("Continue", for: .normal)
        getStartedBtn.layer.cornerRadius =  5
        getStartedBtn.backgroundColor = Color.green
        view.addSubview(getStartedBtn)
        getStartedBtn.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtn.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 50).isActive = true
        getStartedBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getStartedBtn.widthAnchor.constraint(equalToConstant: 270).isActive = true
        
        getStartedBtn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }
    @objc func handleSave(){
        print("okeeee")
        UserDefaultService.gender = genderTextField.text!
        UserDefaultService.age = ageTextField.text!
        
        rootViewS3?.setView(index: 3)
        
            
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension FormScreen3 :  UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100.0
    }
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60.0
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = gender[row]
    }
    
}

