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
        
        if UIScreen.main.bounds.height < 700 {
            imageview.setConstraint(
                topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
                centerXAnchor: view.centerXAnchor,
                heighAnchorConstant: 115, widthAnchorConstant: 95)
        } else {
            imageview.setConstraint(
                topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 80,
                centerXAnchor: view.centerXAnchor,
                heighAnchorConstant: 115, widthAnchorConstant: 95)
        }
        
        titleLabel.text = NSLocalizedString("Nice to meet you!", comment: "")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        titleLabel.setConstraint(
            topAnchor: imageview.bottomAnchor,topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        descLabel.text = NSLocalizedString("Picho will be your buddy throughout this journey, tell him your name so you can get to know each other!", comment: "")
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
        nameTextField.placeholder = NSLocalizedString("Your Name", comment: "")
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        nameTextField.setConstraint(
            topAnchor: descLabel.bottomAnchor, topAnchorConstant: 50,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
        
        getStartedBtn.setTitle( NSLocalizedString("Continue", comment: "") , for: .normal)
        getStartedBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getStartedBtn.layer.cornerRadius =  10
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private var activeTextField: UITextField?
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var shouldMoveViewUp = false
        
        if let activeTextField = activeTextField {
            
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
            
            let topOfKeyboard = self.view.frame.height - keyboardSize.height
            
            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }
        
        if(shouldMoveViewUp) {
            self.view.frame.origin.y = 0 - keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
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
