//
//  HorizontalProgressView.swift
//  Picho
//
//  Created by Windy on 12/11/20.
//

import UIKit

class HorizontalProgressView: UIView {
    
    private var rect: CGRect?
    private var initialProgress: Int = 0
   
    func setProgress(progress: Int) {
        
        guard let rect = rect else { return }
        let progress = Double(progress) / 1400
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * CGFloat(progress), height: rect.height))
        progressLayer.frame = progressRect
    }
    
    private let progressLayer = CALayer()
    
    init(frame: CGRect = .zero, progress: Int) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
        
        self.initialProgress = progress
    }
    
    override func draw(_ rect: CGRect) {
        
        self.rect = rect
        
        let backgroundMask = CAShapeLayer()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask
        layer.backgroundColor = #colorLiteral(red: 0.7576490045, green: 0.7528312802, blue: 0.752771914, alpha: 1)
        
        setProgress(progress: initialProgress)
        
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = Color.blue.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
