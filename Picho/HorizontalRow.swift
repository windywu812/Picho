//
//  HorizontalRow.swift
//  iChol
//
//  Created by Windy on 04/11/20.
//

//import UIKit

//class HorizontalRow: UIView {
//
//    private let label: UILabel
//    private let amountLabel: UILabel
//
//    var preferBold = false
//
//    init(labelString: String, amount: Double, header: Bool = false) {
//        label = UILabel()
//        amountLabel = UILabel()
//
//        super.init(frame: .zero)
//
//        backgroundColor = .red
//
//        label.text = labelString
//        amountLabel.text = "\(amount) g"
//
//        if (header) {
//            label.font = .systemFont(ofSize: 18, weight: .heavy)
//            amountLabel.font = .systemFont(ofSize: 18, weight: .heavy)
//        }
//
//        let mainStack = UIStackView(arrangedSubviews: [label, amountLabel])
//        mainStack.axis = .horizontal
//        mainStack.distribution = .equalCentering
//        addSubview(mainStack)
//
//        mainStack.setConstraint(
//            leadingAnchor: leadingAnchor,
//            trailingAnchor: trailingAnchor,
//            centerYAnchor: centerYAnchor)
//    }
//
//    func setAmount(amount: Double) {
//        amountLabel.text = "\(amount) g"
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//}
