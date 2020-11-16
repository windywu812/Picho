//
//  HorizontalView.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

class HorizontalView: UIView {
    
    private let label: UILabel
    private let detail: UILabel
    private let icon: UIImageView
    
    func setupView(amount: Int) {
        DispatchQueue.main.async {
            let remaining = 15 - amount
            self.detail.text = "💧 \(remaining) cups remaining"
        }
    }
    func setupViewActivity(amount: Int) {
        DispatchQueue.main.async {
            self.detail.text = "🔥 \(amount) Step"
        }
    }
    
    
    init(frame: CGRect = .zero,
         labelText: String,
         detailText: String,
         iconImage: UIImage,
         background: UIColor
    ) {
        
        label = UILabel()
        detail = UILabel()
        icon = UIImageView()
        
        super.init(frame: frame)
        
        backgroundColor = background
        layer.cornerRadius = 8
        
        label.setFont(text: labelText, weight: .bold, color: .white)
        addSubview(label)
        
        icon.image = iconImage
        detail.setFont(text: detailText, weight: .regular, color: .white)
        
        label.setConstraint(
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            centerYAnchor: centerYAnchor)
        
        let stack = UIStackView(arrangedSubviews: [icon, detail])
        stack.axis = .horizontal
        stack.spacing = 4
        addSubview(stack)
        
        stack.setConstraint(
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16,
            centerYAnchor: centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
