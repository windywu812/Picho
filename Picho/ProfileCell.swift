//
//  File.swift
//  Picho
//
//  Created by Windy on 26/11/20.
//

import UIKit

class ProfileCell: UITableViewCell {
    static let reuseIdentifier = "ProfileCell"

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
