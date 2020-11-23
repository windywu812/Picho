//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen5: UIViewController {
    
    private var isChecked = false
    private var getStartedBtn: UIButton!
    
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
       
        let label1 = UILabel()
        label1.text = "Awesome!"
        label1.font = UIFont.boldSystemFont(ofSize: 24.0)
        label1.textAlignment = .center
        view.addSubview(label1)
        
        label1.setConstraint(
            topAnchor: imageview.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16)
        
        let label2 = UILabel()
        label2.text = "Before we proceed further, Picho wanted to remind you..."
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label2)
        
        label2.setConstraint(
            topAnchor: label1.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16)
        
        let label3 = UILabel()
        label3.numberOfLines = 0
        label3.textAlignment = .center
        let attr = NSMutableAttributedString(string: "The information contained in this mobile app should not be used to diagnose or treat any illness. All information is intended for your general knowledge only and is not a substitute for medical advice or treatment for specific medical conditions.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        paragraphStyle.alignment = .center
        attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attr.length))
        label3.attributedText = attr;
        
        view.addSubview(label3)
        label3.setConstraint(
            topAnchor: label2.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16)
        
        let agreementLabel = UILabel()
        agreementLabel.setFont(text: "I have read and I agreed with that.", size: 16)
        agreementLabel.numberOfLines = 0
        
        let checkBox = UIButton()
        checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        checkBox.setConstraint(heighAnchorConstant: 21, widthAnchorConstant: 21)
        checkBox.addTarget(self, action: #selector(self.handleCheckBox(sender:)), for: .touchUpInside)
        
        let stackAgreement = UIStackView(arrangedSubviews: [checkBox, agreementLabel])
        stackAgreement.spacing = 4
        
        view.addSubview(stackAgreement)
        stackAgreement.setConstraint(
            topAnchor: label3.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16)
        
        getStartedBtn = UIButton()
        getStartedBtn.setTitle("Continue", for: .normal)
        getStartedBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getStartedBtn.isEnabled = false
        getStartedBtn.layer.cornerRadius =  10
        getStartedBtn.backgroundColor = Color.lightGreen
        getStartedBtn.tintColor = Color.green
        getStartedBtn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        
        view.addSubview(getStartedBtn)
        getStartedBtn.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50)
    }
    
    @objc private func handleCheckBox(sender: UIButton) {
        isChecked.toggle()
        if isChecked {
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            getStartedBtn.backgroundColor = Color.green
            getStartedBtn.tintColor = .white
            getStartedBtn.isEnabled = true
        } else{
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            getStartedBtn.backgroundColor = Color.lightGreen
            getStartedBtn.tintColor = Color.green
            getStartedBtn.isEnabled = false
        }
    }
    
    @objc private func handleSave() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        UserDefaultService.hasLaunched = true
        HealthKitService.shared.authorization()
        present(vc, animated: true, completion: nil)
 
        return
    }
    
}

