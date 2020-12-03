//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen3: UIViewController {
    private let genders = ["Male", "Female"]
    private let genderTextField = UITextField()
    private let ageTextField = UITextField()
    private let pickerView = UIPickerView()
    private var getStartedBtn = UIButton()
    private var gender: String = ""
    private var age: String = ""

    var rootView: PageControlForm?

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

        if UIScreen.main.bounds.height < 700 {
            imageview.setConstraint(
                topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
                centerXAnchor: view.centerXAnchor,
                heighAnchorConstant: 115, widthAnchorConstant: 95
            )
        } else {
            imageview.setConstraint(
                topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 80,
                centerXAnchor: view.centerXAnchor,
                heighAnchorConstant: 115, widthAnchorConstant: 95
            )
        }

        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("I want to know more about you.", comment: "")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        view.addSubview(titleLabel)

        titleLabel.setConstraint(
            topAnchor: imageview.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )

        let descLabel = UILabel()
        descLabel.text = NSLocalizedString("Different age and gender have different calories needs, also fat and sugar intake. Tell Picho yours so he can help you calculate!", comment: "")
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        view.addSubview(descLabel)

        descLabel.setConstraint(
            topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16
        )

        genderTextField.layer.cornerRadius = 6
        genderTextField.placeholder = NSLocalizedString("Gender", comment: "")
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
            heighAnchorConstant: 50
        )

        ageTextField.addPadding(padding: .equalSpacing(10))
        ageTextField.layer.cornerRadius = 6
        ageTextField.layer.borderColor = Color.green.cgColor
        ageTextField.layer.borderWidth = 2.0
        ageTextField.placeholder = NSLocalizedString("Age", comment: "")
        ageTextField.delegate = self
        ageTextField.keyboardType = .numberPad
        ageTextField.tag = 1
        view.addSubview(ageTextField)

        ageTextField.setConstraint(
            topAnchor: genderTextField.bottomAnchor, topAnchorConstant: 36,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50
        )

        getStartedBtn = UIButton()
        getStartedBtn.setTitle(NSLocalizedString("Continue", comment: ""), for: .normal)
        getStartedBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getStartedBtn.layer.cornerRadius = 10
        getStartedBtn.backgroundColor = Color.lightGreen
        getStartedBtn.tintColor = Color.green
        getStartedBtn.isEnabled = false
        view.addSubview(getStartedBtn)

        getStartedBtn.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50
        )

        getStartedBtn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func handleSave() {
        UserDefaultService.gender = genderTextField.text!
        UserDefaultService.age = ageTextField.text!

        rootView?.setView(index: 3)
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }

    private var activeTextField: UITextField?

    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        var shouldMoveViewUp = false

        if let activeTextField = activeTextField {
            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: view).maxY

            let topOfKeyboard = view.frame.height - keyboardSize.height

            if bottomOfTextField > topOfKeyboard {
                shouldMoveViewUp = true
            }
        }

        if shouldMoveViewUp {
            view.frame.origin.y = 0 - keyboardSize.height
        }
    }

    @objc func keyboardWillHide(notification _: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension FormScreen3: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return genders.count
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        return genders[row]
    }

    func pickerView(_: UIPickerView, rowHeightForComponent _: Int) -> CGFloat {
        return 50.0
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        genderTextField.text = genders[row]
    }
}

extension FormScreen3: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            gender = textField.text ?? ""
        } else {
            age = textField.text ?? ""
        }

        if !gender.isEmpty, !age.isEmpty {
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            gender = genders[0]
            textField.text = gender
        }
        return true
    }
}
