//
//  HorizontalView.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

enum Activity {
    case water
    case activity
}

class HorizontalView: UIView {
    private let label: UILabel
    private let detail: UILabel
    private let icon: UIImageView

    func setupView(amount: Int, type: Activity) {
        if type == .water {
            let remaining = 14 - amount
            detail.text = String(format: NSLocalizedString("💧 %@ cups remaining", comment: ""), String(remaining))
        } else {
            detail.text = "🔥 \(amount) Step"
        }
    }

    init(frame: CGRect = .zero,
         labelText: String,
         iconImage: UIImage,
         background: UIColor)
    {
        label = UILabel()
        detail = UILabel()
        icon = UIImageView()

        super.init(frame: frame)

        backgroundColor = background
        layer.cornerRadius = 8

        label.setFont(text: labelText, weight: .bold, color: .white)
        addSubview(label)

        icon.image = iconImage
        detail.textColor = .white

        setConstraint(heighAnchorConstant: 46)

        label.setConstraint(
            leadingAnchor: leadingAnchor, leadingAnchorConstant: 16,
            centerYAnchor: centerYAnchor
        )

        let stack = UIStackView(arrangedSubviews: [icon, detail])
        stack.axis = .horizontal
        stack.spacing = 4
        addSubview(stack)

        stack.setConstraint(
            trailingAnchor: trailingAnchor, trailingAnchorConstant: -16,
            centerYAnchor: centerYAnchor
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
