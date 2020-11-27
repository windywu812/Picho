//
//  HorizontalProgressView.swift
//  Picho
//
//  Created by Windy on 12/11/20.
//

import UIKit

class HorizontalProgressView: UIView {
    
    private var rect: CGRect?
   
    func setProgress(progress: Int) {
        
        guard let rect = rect else { return }
        let progress = Double(progress) / 14
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * CGFloat(progress), height: rect.height))
        progressLayer.frame = progressRect
    }
    
    private let progressLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
        
    }
    
    override func draw(_ rect: CGRect) {
        
        self.rect = rect
        
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        layer.backgroundColor = #colorLiteral(red: 0.7576490045, green: 0.7528312802, blue: 0.752771914, alpha: 1)
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = Color.blue.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
