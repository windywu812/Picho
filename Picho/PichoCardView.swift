//
//  PichoCardView.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

enum PichoCardType {
    case syncHealhtKit
    case breakfast
    case lunch
    case dinner
}

class PichoCardView: UIView {
    
    private let mascotImage: UIImageView
    private let titleLabel: UILabel
    private let detailLabel: UILabel
    private let button: UIButton
    private let rootView: UIViewController
    private let type: PichoCardType
    
    init(frame: CGRect = .zero,
         mascot: String,
         title: String,
         detail: String,
         buttonText: String,
         type: PichoCardType,
         rootView: UIViewController
    ) {
        
        mascotImage = UIImageView()
        titleLabel = UILabel()
        detailLabel = UILabel()
        button = UIButton(type: .system)
        self.type = type
        self.rootView = rootView
        
        super.init(frame: frame)
        
        addSubview(mascotImage)
        addSubview(button)
        
        backgroundColor = Color.green
        layer.cornerRadius = 8
        
        mascotImage.image = UIImage(named: mascot)
        mascotImage.contentMode = .scaleAspectFit
        
        titleLabel.setFont(
            text: title,
            size: 20,
            weight: .bold,
            color: .white)
        
        detailLabel.setFont(
            text: detail,
            color: .white)
        detailLabel.numberOfLines = 0
        
        button.setTitle(buttonText, for: .normal)
        button.tintColor = .label
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleTap(sender:)), for: .touchUpInside)
        
        setupLayout()
    }
    
    @objc private func handleTap(sender: UIButton) {
        switch type {
        case .breakfast:
            let vc = FoodInputViewController()
            vc.eatingTime = .breakfast
            rootView.navigationController?.pushViewController(vc, animated: true)
        case .lunch:
            let vc = FoodInputViewController()
            vc.eatingTime = .lunch
            rootView.navigationController?.pushViewController(vc, animated: true)
        case .dinner:
            let vc = FoodInputViewController()
            vc.eatingTime = .dinner
            rootView.navigationController?.pushViewController(vc, animated: true)
        case .syncHealhtKit:
            HealthKitService.shared.authorization()
        }
        
    }
    
    private func setupLayout() {
        let mainStack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        mainStack.axis = .vertical
        mainStack.spacing = 4
        addSubview(mainStack)

        setConstraint(heighAnchorConstant: 130)
        
        mascotImage.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -8,
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 8,
            widthAnchorConstant: 101)

        mainStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            leadingAnchor: mascotImage.trailingAnchor, leadingAnchorConstant: 8,
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -8)

        button.setConstraint(
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: mascotImage.trailingAnchor, leadingAnchorConstant: 8, heighAnchorConstant: 30, widthAnchorConstant: 115)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
