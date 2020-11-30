//
//  ProfileViewController.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    private var topHeader: TopProfile?
    private let viewModel = ProfileViewModel()
    
    override init(style: UITableView.Style = .grouped) {
        super.init(style: .grouped)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchUserDefault()
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Profile", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))
        setupTableView()
    }
    
    @objc private func handleEdit() {
        let vc = ProfileEditViewController()
        vc.viewModel = viewModel
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupTableView() {
        tableView.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.reuseIdentifier)
        tableView.isScrollEnabled = false
        tableView.backgroundColor = Color.background
    }
    
    @objc private func handleSwitch(sender: UISwitch) {
        viewModel.handleSwitch(value: sender.isOn)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            topHeader = TopProfile()
            topHeader?.setupView(name: viewModel.fullName, image: viewModel.getPic(forKey: UserDefaultService.photoProfileKey))
            return topHeader
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.reuseIdentifier) as! ProfileCell
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = viewModel.secondSectionLabel[indexPath.row]
            if indexPath.row == 2 {
                cell.detailTextLabel?.text = "\(viewModel.secondSection[2]) cm"
                break
            } else if indexPath.row == 3 {
                cell.detailTextLabel?.text = "\(viewModel.secondSection[3]) kg"
                break
            }
            cell.detailTextLabel?.text = viewModel.secondSection[indexPath.row]
        case 1:
            cell.textLabel?.text = viewModel.thirdSectionLabel[indexPath.row]
            if indexPath.row == 0 {
               
            } else {
                cell.accessoryType = .disclosureIndicator
            }
        default:
            break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let vc = NotificationViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 0 {
                if HealthKitService.shared.checkAuthorization(){
                    let alert = UIAlertController(title: NSLocalizedString("Turn Off HealhKit", comment: ""), message:NSLocalizedString("Go to setting -> Health -> Data accsess & Devices -> Picho -> Turn All Categories Off ", comment: "") , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:NSLocalizedString("Cancel", comment: ""), style: UIAlertAction.Style.default, handler: { action in

                    }))
                    alert.addAction(UIAlertAction(title:NSLocalizedString("Go to Setting", comment: "") , style: UIAlertAction.Style.default, handler: { action in
                        UIApplication.shared.open(URL(string: "App-prefs:Health")!)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title:NSLocalizedString("Connect to Health Apps", comment: "") , message:NSLocalizedString("Turn All Categories On", comment: "") , preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Connect", comment: ""), style: UIAlertAction.Style.default, handler: nil))
                    HealthKitService.shared.authorization()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TopProfile: UIView {
    
    private var imageProfile: UIImageView!
    private var nameLabel: UILabel!
    
    func setupView(name: String, image: UIImage) {
        imageProfile.image = image
        imageProfile.layer.cornerRadius = 60
        imageProfile.layer.borderWidth = 2
        imageProfile.layer.borderColor = Color.green.cgColor
        imageProfile.layer.masksToBounds = true
        nameLabel.setFont(text: name, size: 24, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageProfile = UIImageView()
        addSubview(imageProfile)
        imageProfile.setConstraint(
            topAnchor: topAnchor, topAnchorConstant: 8,
            centerXAnchor: centerXAnchor,
            heighAnchorConstant: 120, widthAnchorConstant: 120)
        
        nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = 8
        nameLabel.backgroundColor = Color.background
        addSubview(nameLabel)
        
        nameLabel.setConstraint(
            topAnchor: imageProfile.bottomAnchor, topAnchorConstant: 32,
            bottomAnchor: bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: leadingAnchor,
            trailingAnchor: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
