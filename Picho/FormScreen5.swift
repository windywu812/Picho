//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen5: UIViewController {
    
    var isChecked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let image = UIImage(named: "mascot")
        let imageview:UIImageView = UIImageView()
        imageview.contentMode = UIView.ContentMode.scaleToFill
        imageview.image = image
        view.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageview.topAnchor.constraint(equalTo: view.topAnchor,constant: 20).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 95).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 115).isActive = true
        
        let label1 = UILabel()
        label1.text = "Great!"
        label1.font = UIFont.boldSystemFont(ofSize: 25.0)
        view.addSubview(label1)
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label1.topAnchor.constraint(equalTo: imageview.bottomAnchor,constant: 20).isActive = true
        
        let label2 = UILabel()
        label2.text = "Before we proceed further, Picho wanted to remind you..."
        label2.numberOfLines = 0
        label2.textAlignment = .center
        label2.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(label2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        label2.topAnchor.constraint(equalTo: label1.bottomAnchor,constant: 20).isActive = true
        
        let label3 = UILabel()
        label3.font = UIFont.systemFont(ofSize: 17)
        label3.numberOfLines = 0
        label3.textAlignment = .center
        let attr = NSMutableAttributedString(string: "The information contained in this mobile app should not be used to diagnose or treat any illness. All information is intended for your general knowledge only and is not a substitute for medical advice or treatment for specific medical conditions.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attr.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attr.length))
        label3.attributedText = attr;
        
        view.addSubview(label3)
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label3.widthAnchor.constraint(equalToConstant: 270).isActive = true
        label3.topAnchor.constraint(equalTo: label2.bottomAnchor,constant: 50).isActive = true
        
        let agreementLabel = UILabel()
        agreementLabel.setFont(text: "I have read and I agreed with that.", size: 16, weight: .regular, color: .black)
        agreementLabel.numberOfLines = 0
        
        let checkBox = UIButton()
        checkBox.setImage(UIImage(systemName: "circle"), for: .normal)
        checkBox.setConstraint(heighAnchorConstant: 21, widthAnchorConstant: 21)
        checkBox.addTarget(self, action: #selector(self.handleCheckBox(sender:)), for: .touchUpInside)
        var stackAgreement = UIStackView()
        stackAgreement = UIStackView(arrangedSubviews: [checkBox, agreementLabel])
        stackAgreement.axis = .horizontal
        stackAgreement.spacing = 0
        
        view.addSubview(stackAgreement)
        stackAgreement.setConstraint(topAnchor: label3.bottomAnchor, topAnchorConstant: 20, centerXAnchor: view.centerXAnchor, centerXAnchorConstant: 0,widthAnchorConstant: 270)
        
        let getStartedBtn = UIButton()
        getStartedBtn.setTitle("LET’S DO THIS!", for: .normal)
        getStartedBtn.isEnabled = false
        getStartedBtn.layer.cornerRadius =  5
        getStartedBtn.backgroundColor = Color.green
        view.addSubview(getStartedBtn)
        getStartedBtn.translatesAutoresizingMaskIntoConstraints = false
        getStartedBtn.topAnchor.constraint(equalTo: stackAgreement.bottomAnchor, constant: 20).isActive = true
        getStartedBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getStartedBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        getStartedBtn.widthAnchor.constraint(equalToConstant: 270).isActive = true
    }
    @objc func handleCheckBox(sender: UIButton) {
        isChecked = !isChecked
        if isChecked{
            sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            sender.isEnabled = true
        }
        else{
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            sender.isEnabled = false
        }
    }
    
}

