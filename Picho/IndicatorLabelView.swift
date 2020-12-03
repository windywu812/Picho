//
//  IndicatorLabelView.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit

class IndicatorLabelView: UIView {
    private var greenIcon: UIImageView!
    private var yellowIcon: UIImageView!
    private var redIcon: UIImageView!

    private var greenLabel: UILabel!
    private var yellowLabel: UILabel!
    private var redLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)

        greenIcon = UIImageView()
        greenIcon.image = UIImage(named: "green_indicator")

        yellowIcon = UIImageView()
        yellowIcon.image = UIImage(named: "yellow_indicator")

        redIcon = UIImageView()
        redIcon.image = UIImage(named: "red_indicator")

        greenLabel = UILabel()
        greenLabel.setFont(text: NSLocalizedString("Within ±10% of allowance", comment: ""), size: 13, color: .secondaryLabel)

        yellowLabel = UILabel()
        yellowLabel.setFont(text: NSLocalizedString("Within ±20% of allowance", comment: ""), size: 13, color: .secondaryLabel)

        redLabel = UILabel()
        redLabel.setFont(text: NSLocalizedString("Within ±30% of allowance", comment: ""), size: 13, color: .secondaryLabel)

        let greenIndicatorStack = UIStackView(arrangedSubviews: [greenIcon, greenLabel])
        greenIndicatorStack.axis = .horizontal
        greenIndicatorStack.spacing = 8
        addSubview(greenIndicatorStack)

        greenIndicatorStack.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 16,
            centerXAnchor: centerXAnchor
        )

        greenIcon.setConstraint(
            heighAnchorConstant: 16, widthAnchorConstant: 16
        )

        let yellowIndicatorStack = UIStackView(arrangedSubviews: [yellowIcon, yellowLabel])
        yellowIndicatorStack.axis = .horizontal
        yellowIndicatorStack.spacing = 8
        addSubview(yellowIndicatorStack)

        yellowIndicatorStack.setConstraint(
            topAnchor: greenIndicatorStack.bottomAnchor, topAnchorConstant: 4,
            centerXAnchor: centerXAnchor
        )

        yellowIcon.setConstraint(
            heighAnchorConstant: 16, widthAnchorConstant: 16
        )

        let redIndicatorStack = UIStackView(arrangedSubviews: [redIcon, redLabel])
        redIndicatorStack.axis = .horizontal
        redIndicatorStack.spacing = 8
        addSubview(redIndicatorStack)

        redIndicatorStack.setConstraint(
            topAnchor: yellowIndicatorStack.bottomAnchor, topAnchorConstant: 4,
            bottomAnchor: bottomAnchor,
            centerXAnchor: centerXAnchor
        )

        redIcon.setConstraint(
            heighAnchorConstant: 16, widthAnchorConstant: 16
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
