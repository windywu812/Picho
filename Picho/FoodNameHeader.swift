//
//  FoodNameHeader.swift
//  Picho
//
//  Created by Windy on 29/11/20.
//

import UIKit

class FoodNameHeader: UIView {
    
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.setFont(text: "", size: 28, weight: .bold)
        nameLabel.numberOfLines = 0
        addSubview(nameLabel)
        nameLabel.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 10,
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




