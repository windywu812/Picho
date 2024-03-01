//
//  CircularProgressView.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import UIKit

class CircularProgressView: UIView {
    private let shapeLayer: CAShapeLayer
    private let calorieLabel: UILabel

    func animate(value: Float, total: Float) {
        if value < 0 {
            calorieLabel.setFont(
                text: "\(-Int(value - total))", size: 28,
                weight: .bold,
                color: Color.green
            )
        } else {
            calorieLabel.setFont(
                text: "\(Int(value))", size: 28,
                weight: .bold,
                color: Color.green
            )
        }

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = (total - value) / total
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        shapeLayer.add(animation, forKey: "progressAnimation")
    }

    override init(frame: CGRect) {
        shapeLayer = CAShapeLayer()
        calorieLabel = UILabel()

        super.init(frame: frame)

        let label = UILabel()
        label.setFont(
            text: "Cal left",
            size: 15
        )

        let mainStack = UIStackView(arrangedSubviews: [calorieLabel, label])
        mainStack.axis = .vertical
        mainStack.alignment = .center
        addSubview(mainStack)

        mainStack.setConstraint(
            centerXAnchor: centerXAnchor,
            centerYAnchor: centerYAnchor
        )

        setupLayer()
    }

    private func setupLayer() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: 50, y: 50),
            radius: 55,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )

        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        trackLayer.strokeColor = Color.grey.cgColor
        trackLayer.lineWidth = 8
        layer.addSublayer(trackLayer)

        shapeLayer.lineCap = .round
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = Color.green.cgColor
        shapeLayer.lineWidth = 8
        shapeLayer.strokeStart = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
