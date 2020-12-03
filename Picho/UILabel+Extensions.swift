//
//  UILabel+Extensions.swift
//  Picho
//
//  Created by Windy on 09/11/20.
//

import UIKit

extension UILabel {
    func setFont(text: String,
                 size: CGFloat = 17,
                 weight: UIFont.Weight = .regular,
                 color: UIColor = .label)
    {
        font = .systemFont(ofSize: size, weight: weight)
        self.text = text
        textColor = color
    }
}
