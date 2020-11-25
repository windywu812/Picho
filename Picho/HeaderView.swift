////
////  HeaderView.swift
////  Picho
////
////  Created by Windy on 13/11/20.
////
//
//import UIKit
//
//class HeaderView: UIView {
//    
//    private var label: UILabel!
//    
//    @objc private func handleTap(sender: UITapGestureRecognizer) {
//        print("Tap")
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        label = UILabel()
//        label.setFont(text: ("Highest Week Comsuption").uppercased(), size: 13, color: .secondaryLabel)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//        label.addGestureRecognizer(tap)
//        label.isUserInteractionEnabled = true
//        
//        addSubview(label)
//        backgroundColor = Color.background
//        
//        label.setConstraint(
//            topAnchor: topAnchor, topAnchorConstant: 8,
//            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
//            leadingAnchor: layoutMarginsGuide.leadingAnchor,
//            trailingAnchor: trailingAnchor, trailingAnchorConstant: -8)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
