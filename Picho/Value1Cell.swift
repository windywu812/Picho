//
//  ProfileCell.swift
//  iChol
//
//  Created by Windy on 08/11/20.
//

import UIKit

class Value1Cell: UITableViewCell {
    
    static let reuseIdentifier = "Value1Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
