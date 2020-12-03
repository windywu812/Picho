//
//  DetailSugarNSatFat.swift
//  Picho
//
//  Created by Muhammad Rasyid khaikal on 12/11/20.
//

import UIKit

class DetailSugarNSatFat: UIViewController {
    let labelTittle = UILabel()
    let labelDescription1 = UILabel()
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.background

        scrollView.backgroundColor = Color.background
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)

        scrollView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )

        labelTittle.setFont(text: "Saturated Fat and Sugar", size: 22, weight: .bold)
        scrollView.addSubview(labelTittle)

        labelTittle.setConstraint(
            topAnchor: scrollView.topAnchor, topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor
        )

        labelDescription1.setFont(text: NSLocalizedString("Both saturated fat and sugar can trigger increase in ‘bad’ cholesterol (LDL). Sugar, in particular, can also cause triglycerides in our body to go up.", comment: ""), size: 16, weight: .regular, color: .black)
        labelDescription1.numberOfLines = 0
        scrollView.addSubview(labelDescription1)

        labelDescription1.setConstraint(
            topAnchor: labelTittle.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )

        let image = UIImage(named: "Detail")
        let imageview = UIImageView()
        imageview.contentMode = .scaleToFill
        imageview.image = image
        scrollView.addSubview(imageview)

        imageview.setConstraint(
            topAnchor: labelDescription1.bottomAnchor, topAnchorConstant: 20,
            centerXAnchor: scrollView.centerXAnchor,
            heighAnchorConstant: 239,
            widthAnchorConstant: 332
        )

        let label2 = UILabel()
        label2.text = "Triglycerides are the kind of fat that our body make when there is excess sugar in our blood stream.\n\nHigh triglycerides cause hardening on the arteries' wall (atherosclerosis), increasing your risk of stroke, heart attack and heart disease\n\nNow that we’ve talked about this, Picho will show you how to log your foods!"
        label2.numberOfLines = 0
        scrollView.addSubview(label2)

        label2.setConstraint(
            topAnchor: imageview.bottomAnchor, topAnchorConstant: 20,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )

        let getStartedBtn = UIButton()
        getStartedBtn.setTitle("LOG MY BREAKFAST", for: .normal)
        getStartedBtn.isEnabled = false
        getStartedBtn.layer.cornerRadius = 5
        getStartedBtn.backgroundColor = Color.green
        scrollView.addSubview(getStartedBtn)

        getStartedBtn.setConstraint(
            topAnchor: label2.bottomAnchor, topAnchorConstant: 20,
            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 50
        )
    }
}
