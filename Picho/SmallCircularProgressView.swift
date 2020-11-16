//
//  SmallCircularProgressView.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

class SmallCircularProgressView: UIView {
    
    private let shapeLayer: CAShapeLayer
    
    override init(frame: CGRect) {
        shapeLayer = CAShapeLayer()
        super.init(frame: frame)
        setupLayer()
    }
    
    func animate(value: Float, total: Float) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = (total - value) / total
        animation.duration = 2
        animation.fromValue = 0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        
        if (total - value) / total > 1 {
            shapeLayer.strokeColor = Color.red.cgColor
        }
        
        shapeLayer.add(animation, forKey: "progressAnimation")
    }
    
    private func setupLayer() {
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: 25, y: 25),
            radius: 20,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true)
        
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = .round
        trackLayer.strokeColor = Color.grey.cgColor
        trackLayer.lineWidth = 4
        layer.addSublayer(trackLayer)
        
        shapeLayer.lineCap = .round
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = Color.yellow.cgColor
        shapeLayer.lineWidth = 6
        shapeLayer.strokeStart = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(shapeLayer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
