//
//  LegendView.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit

class LegendView: UIView {
    
    private var label: UILabel!
    private var image: UIImageView!
    
    init(frame: CGRect = .zero, text: String, color: UIColor) {
        super.init(frame: frame)
        
        label = UILabel()
        label.text = text
        layer.cornerRadius = 8
        backgroundColor = .white
        
        let circle = UIView()
        circle.backgroundColor = color
        circle.layer.cornerRadius = 10
        circle.layer.borderWidth = 3
        circle.layer.borderColor = UIColor.white.cgColor
        
        circle.layer.shadowColor = UIColor.black.cgColor
        circle.layer.shadowRadius = 5
        circle.layer.shadowOpacity = 0.1
        circle.layer.shadowOffset = CGSize(width: 0, height: 4)
        circle.layer.masksToBounds = false
          
        addSubview(circle)
        circle.setConstraint(
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            centerYAnchor: centerYAnchor,
            heighAnchorConstant: 20, widthAnchorConstant: 20)
        
        addSubview(label)
        label.setConstraint(
            leadingAnchor: circle.trailingAnchor, leadingAnchorConstant: 8,
            centerYAnchor: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
