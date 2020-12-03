//
//  Form1.swift
//  onBoardingDummy
//
//  Created by Muhammad Rasyid khaikal on 10/11/20.
//

import UIKit

class FormScreen1: UIViewController {
    var rootView: PageControlForm?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.background

        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.image = UIImage(named: "mascot")
        view.addSubview(imageview)

        if UIScreen.main.bounds.height < 700 {
            imageview.setConstraint(
                topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
                centerXAnchor: view.centerXAnchor,
                heighAnchorConstant: 115, widthAnchorConstant: 95
            )
        } else {
            imageview.setConstraint(
                topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 80,
                centerXAnchor: view.centerXAnchor,
                heighAnchorConstant: 115, widthAnchorConstant: 95
            )
        }

        let titleLabel = UILabel()
        titleLabel.text = NSLocalizedString("Picho is here to help!", comment: "")
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.addSubview(titleLabel)

        titleLabel.setConstraint(
            topAnchor: imageview.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )

        let descLabel = UILabel()
        descLabel.text = NSLocalizedString("Picho needs the following information to help you with your recommended daily intake of calorie, saturated fat and sugar.", comment: "")
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        view.addSubview(descLabel)

        descLabel.setConstraint(
            topAnchor: titleLabel.bottomAnchor, topAnchorConstant: 24,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16
        )

        let getStartedBtn = UIButton()
        getStartedBtn.setTitle(NSLocalizedString("Alrighty!", comment: ""), for: .normal)
        getStartedBtn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        getStartedBtn.layer.cornerRadius = 10
        getStartedBtn.backgroundColor = Color.green
        view.addSubview(getStartedBtn)

        getStartedBtn.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 16,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            heighAnchorConstant: 50
        )

        getStartedBtn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
    }

    @objc func handleSave() {
        rootView?.setView(index: 1)
    }
}
