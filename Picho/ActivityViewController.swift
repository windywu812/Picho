//
//  ActivityViewController.swift
//  Picho
//
//  Created by Windy on 11/11/20.
//

import UIKit

class ActivityViewController: UIViewController {
    let detailText = NSLocalizedString("By losing fat and building muscles, you can increase your ‘good’ HDL (high-density lipoprotein) cholesterol  while decreasing your ‘bad’ LDL (low-density lipoprotein) cholesterol at the same time! That’s just killing two birds with one stone, right?Picho can help you track your burned calories and adjust your daily intake better when linked to Health.", comment: "")

    private var descriptionLabel: UILabel!
    private var cardView: PichoCardView?
    private var activityCard: HorizontalView!

    var viewModel: JournalViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = NSLocalizedString("Activity", comment: "")

        setupView()
        setupLayout()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""), style: .done, target: self, action: #selector(handleClose))
    }

    private func setupView() {
        view.backgroundColor = Color.background

        descriptionLabel = UILabel()
        descriptionLabel.text = detailText
        descriptionLabel.numberOfLines = 0
        view.addSubview(descriptionLabel)

        if !HealthKitService.shared.checkAuthorization() {
            cardView = PichoCardView(
                mascot: "mascot",
                title: "Activity \"Health\"",
                detail: NSLocalizedString("For better result, connect Picho to Apple Health", comment: ""),
                buttonText: NSLocalizedString("Connect to ❤️", comment: ""),
                type: .syncHealhtKit,
                rootView: self
            )
        }

        activityCard = HorizontalView(
            labelText: NSLocalizedString("Activity", comment: ""),
            iconImage: UIImage(),
            background: Color.red
        )
        activityCard.setupView(amount: Int(viewModel.totalStep), type: .activity)
    }

    private func setupLayout() {
        descriptionLabel.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )

        let stack = UIStackView(arrangedSubviews: [activityCard, cardView].compactMap { $0 })
        stack.axis = .vertical
        stack.spacing = 32
        view.addSubview(stack)

        stack.setConstraint(
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )
    }

    @objc private func handleClose() {
        dismiss(animated: true, completion: nil)
    }
}
