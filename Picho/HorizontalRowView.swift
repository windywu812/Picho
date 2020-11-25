////
////  HorizontalRowView.swift
////  Picho
////
////  Created by Windy on 13/11/20.
////
//
//import UIKit
//
//class HorizontalRowView: UIView {
//    
//    private var label: UILabel!
//    private var amountLabel: UILabel!
//    private var imageLabel: UIImageView!
//    
//    func setupView(labelText: String, amountText: Double, icon: String) {
//        label.text = labelText
//        if labelText.contains(find: "Calories") {
//            amountLabel.text = "\(String(format: "%.02f", amountText)) cal"
//        } else {
//            amountLabel.text = "\(String(format: "%.02f", amountText)) g"
//        }
//        imageLabel.image = UIImage(named: icon)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        let divider = UIView()
//        divider.backgroundColor = .tertiaryLabel
//        addSubview(divider)
//        
//        label = UILabel()
//        amountLabel = UILabel()
//        imageLabel = UIImageView()
//        
//        addSubview(label)
//        addSubview(amountLabel)
//        addSubview(imageLabel)
//        
//        backgroundColor = .white
//        
//        amountLabel.textColor = .secondaryLabel
//        
//        divider.setConstraint(
//            topAnchor: topAnchor,
//            leadingAnchor: leadingAnchor,
//            trailingAnchor: trailingAnchor,
//            heighAnchorConstant: 1)
//        
//        label.setConstraint(
//            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
//            centerYAnchor: centerYAnchor)
//        
//        imageLabel.setConstraint(
//            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16,
//            centerYAnchor: centerYAnchor,
//            heighAnchorConstant: 22, widthAnchorConstant: 22)
//        
//        amountLabel.setConstraint(
//            trailingAnchor: imageLabel.leadingAnchor, trailingAnchorConstant: -16,
//            centerYAnchor: centerYAnchor)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
