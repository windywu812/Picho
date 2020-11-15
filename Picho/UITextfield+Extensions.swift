//
//  UITextfield.swift
//  Picho
//
//  Created by Windy on 11/11/20.
//

import UIKit

extension UITextField {
    
    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }
    
    func addPadding(padding: PaddingSpace) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        switch padding {
        
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = leftPaddingView
            self.leftViewMode = .always
            
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = rightPaddingView
            self.rightViewMode = .always
            
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = equalPaddingView
            self.leftViewMode = .always
            // right
            self.rightView = equalPaddingView
            self.rightViewMode = .always
        }
    }
    
    func addStyle(tag: Int, text: String, datePicker: UIDatePicker) {
        self.tag = tag
        self.text = text
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = Color.green.cgColor
        self.layer.borderWidth = 2.0
        self.textAlignment = .center
        self.inputView = datePicker
        self.addPadding(padding: .equalSpacing(5))
    }
    
    func removeBorder(tag: Int, text: String) {
        self.tag = tag
        self.text = text
        self.textAlignment = .right
        self.borderStyle = .none
        self.keyboardType = .numberPad
    }
    
}

extension UIDatePicker {
    
    func setupStyle(tag: Int) {
        self.tag = tag
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
            self.datePickerMode = .time
        } else {
            // Fallback on earlier versions
        }
    }
    
}
