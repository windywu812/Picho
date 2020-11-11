//
//  DetailCell.swift
//  Picho
//
//  Created by Wendy Kurniawan on 10/11/20.
//

import UIKit

class DetailCell: UITableViewCell {
    
    static let reuseIdentifier = "DetailCell"
    
    func configureCell(label: String, value: Double, header: Bool = false) {
        textLabel?.text = label
        detailTextLabel?.text = String("\(value)g")
        
        if header {
            textLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
            detailTextLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
