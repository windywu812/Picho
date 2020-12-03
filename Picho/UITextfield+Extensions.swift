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
        leftViewMode = .always
        layer.masksToBounds = true

        switch padding {
        case let .left(spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            leftView = leftPaddingView
            leftViewMode = .always

        case let .right(spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            rightView = rightPaddingView
            rightViewMode = .always

        case let .equalSpacing(spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            // left
            leftView = equalPaddingView
            leftViewMode = .always
            // right
            rightView = equalPaddingView
            rightViewMode = .always
        }
    }

    func addStyle(tag: Int, text: String, datePicker: UIDatePicker) {
        self.tag = tag
        self.text = text
        layer.cornerRadius = 5.0
        layer.borderColor = Color.green.cgColor
        layer.borderWidth = 2.0
        textAlignment = .center
        inputView = datePicker
        tintColor = .clear
        addPadding(padding: .equalSpacing(5))
    }

    func removeBorder(tag: Int, text: String) {
        self.tag = tag
        self.text = text
        textAlignment = .right
        borderStyle = .none
        keyboardType = .numberPad
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
