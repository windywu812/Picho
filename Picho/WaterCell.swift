//
//  WaterCell.swift
//  Picho
//
//  Created by Windy on 26/11/20.
//

import UIKit

class WaterCell: UICollectionViewCell {
    
    static let reuseIdentifier = "WaterCell"
    
    var image: UIImage? {
        didSet { imageView.image = image }
    }
    
    private let imageView: UIImageView
    
    override init(frame: CGRect) {
        
        imageView = UIImageView()
        
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.setConstraint(
            topAnchor: topAnchor,
            bottomAnchor: bottomAnchor,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
