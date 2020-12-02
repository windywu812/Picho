//
//  File.swift
//  Picho
//
//  Created by Windy on 26/11/20.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    static let reuseIdentifier = "ProfileCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
