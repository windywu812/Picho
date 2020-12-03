//
//  NutrionalHeader.swift
//  Picho
//
//  Created by Windy on 29/11/20.
//

import UIKit

class NutrionalHeader: UIView {
    private var nutritionLabel: UILabel!
    private var serveLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        nutritionLabel = UILabel()
        nutritionLabel.setFont(text: NSLocalizedString("Nutritional Information", comment: ""), size: 28, weight: .bold)
        addSubview(nutritionLabel)
        nutritionLabel.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            leadingAnchor: layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 10
        )

        serveLabel = UILabel()
        serveLabel.setFont(text: NSLocalizedString("Per serve", comment: ""), weight: .bold)
        addSubview(serveLabel)
        serveLabel.setConstraint(
            topAnchor: nutritionLabel.bottomAnchor, topAnchorConstant: 16,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -10
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
