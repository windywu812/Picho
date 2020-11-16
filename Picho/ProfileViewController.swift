//
//  ProfileViewController.swift
//  iChol
//
//  Created by Windy on 07/11/20.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var imageProfile: UIImageView!
    private var nameLabel: UILabel!
    private var tableView: UITableView!
    private var scrollView: UIScrollView!
    
    let viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchUserDefault()
        if viewModel.getPic(forKey: UserDefaultService.photoProfileKey) == nil {
            imageProfile.image = UIImage(systemName: "person.circle")
        } else {
            imageProfile.image = viewModel.getPic(forKey: UserDefaultService.photoProfileKey)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(handleEdit))
        setupView()
        setupTableView()
    }
    
    @objc private func handleEdit() {
        navigationController?.pushViewController(ProfileEditViewController(), animated: true)
    }
    
    private func setupView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = Color.background
        view.addSubview(scrollView)
        
        scrollView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor)
        
        imageProfile = UIImageView()
       
        scrollView.addSubview(imageProfile)
        
        imageProfile.setConstraint(
            topAnchor: scrollView.topAnchor, topAnchorConstant: 8,
            centerXAnchor: view.centerXAnchor,
            heighAnchorConstant: 120, widthAnchorConstant: 120)
        
        nameLabel = UILabel()
        nameLabel.setFont(text: viewModel.fullName, size: 24, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.layer.cornerRadius = 8
        nameLabel.backgroundColor = Color.background
        scrollView.addSubview(nameLabel)
        
        nameLabel.setConstraint(
            topAnchor: imageProfile.bottomAnchor, topAnchorConstant: 32,
            centerXAnchor: view.centerXAnchor,
            heighAnchorConstant: 35, widthAnchorConstant: 106)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(Value1Cell.self, forCellReuseIdentifier: Value1Cell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = Color.background
        scrollView.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        var totalRow = 0
        for section in 0..<tableView.numberOfSections {
            totalRow += tableView.numberOfRows(inSection: section)
        }
        let totalHeight = 40 * tableView.numberOfSections + totalRow * 44
                
        tableView.setConstraint(
            topAnchor: nameLabel.bottomAnchor, topAnchorConstant: 0,
            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: 0,
            leadingAnchor: safeArea.leadingAnchor, leadingAnchorConstant: 0,
            trailingAnchor: safeArea.trailingAnchor, trailingAnchorConstant: 0,
            heighAnchorConstant: CGFloat(totalHeight))
    }
    
    @objc private func handleSwitch(sender: UISwitch) {
        viewModel.handleSwitch(value: sender.isOn)
    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Value1Cell.reuseIdentifier) as! Value1Cell
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
                let control = UISwitch()
                control.isOn = viewModel.isSync
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                cell.accessoryType = .disclosureIndicator
            }
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                let vc = NotificationViewController()
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
}
