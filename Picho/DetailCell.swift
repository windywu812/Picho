//
//  DetailCell.swift
//  Picho
//
//  Created by Wendy Kurniawan on 10/11/20.
//

import UIKit

class DetailCell: UITableViewCell {
    static let reuseIdentifier = "DetailCell"

    func configureCell(label: String, value: Double, header: Bool = false, unit: String = "g") {
        textLabel?.text = label
        detailTextLabel?.text = String("\(value)\(unit)")

        if header {
            textLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
            detailTextLabel?.font = .systemFont(ofSize: 17, weight: .heavy)
        }
    }

    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
