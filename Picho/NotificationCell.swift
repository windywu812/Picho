//
//  NotificationCell.swift
//  Picho
//
//  Created by Windy on 21/11/20.
//

import UIKit

class NotificationCell: UITableViewCell {
    
    static let reuseIdentifier = "NotificationCell"
    
    let iconImage: UIImageView
    let title: UILabel
    
    func setupEmptyState() {
        iconImage.image = UIImage(named: "")
        title.text = ""
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        iconImage = UIImageView()
        title = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImage.contentMode = .scaleAspectFill
        
        let stack = UIStackView(arrangedSubviews: [iconImage, title])
        stack.spacing = 8
        addSubview(stack)
        
        stack.setConstraint(
            leadingAnchor: layoutMarginsGuide.leadingAnchor,
            centerYAnchor: centerYAnchor)
        
        iconImage.setConstraint(
            heighAnchorConstant: 22, widthAnchorConstant: 22)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
