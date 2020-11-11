//
//  FoodInputViewController.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import UIKit
import Combine

class FoodInputViewController: UIViewController {
    
    private var mascotImage: UIImageView!
    private var titleLabel: UILabel!
    private var addButton: UIButton!
    private var tableView: UITableView!
    
    var timeLabel: String = ""
    
    private let foods = [
        SearchedFood(id: "5873608", name: "Nasi Goreng", description: "Per 1122g - Calories: 1850kcal | Fat: 65.44g | Carbs: 240.17g | Protein: 69.07g", brand: nil, type: "Generic", url: "https://www.fatsecret.com/calories-nutrition/generic/nasi-goreng"),
        SearchedFood(id: "5873608", name: "Nasi Goreng", description: "Per 1122g - Calories: 1850kcal | Fat: 65.44g | Carbs: 240.17g | Protein: 69.07g", brand: nil, type: "Generic", url: "https://www.fatsecret.com/calories-nutrition/generic/nasi-goreng")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTable()
        setupLayout()
        
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupView() {
        view.backgroundColor = Color.background
        
        mascotImage = UIImageView()
        mascotImage.image = UIImage(named: "mascot")
        mascotImage.contentMode = .scaleAspectFit
        view.addSubview(mascotImage)
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.text = "Would you mind to share your \n\(timeLabel) with me?"
        
        addButton = UIButton()
        addButton.backgroundColor = Color.green
        addButton.layer.cornerRadius = 8
        addButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: view.safeAreaInsets.left, bottom: 12, right: view.safeAreaInsets.right)
        addButton.setTitle("Add \(timeLabel)", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        
//        separator = UIView()
//        separator.frame = CGRect(x: 0, y: 200, width: self.view.bounds.size.width, height: 1)
//        separator.backgroundColor = .red
//        view.addSubview(separator)
    }
    
    private func setupTable() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.reuseIdentifier)
        
        tableView.backgroundColor = Color.background
        tableView.rowHeight = 130
        tableView.showsVerticalScrollIndicator = false
        
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        let mainStack = UIStackView(arrangedSubviews: [titleLabel, addButton])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        view.addSubview(mainStack)
        
        mascotImage.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
            centerXAnchor: view.centerXAnchor,
            heighAnchorConstant: 155, widthAnchorConstant: 135)
        
        mainStack.setConstraint(
            topAnchor: mascotImage.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)

//        separator.setConstraint(
//            topAnchor: mainStack.bottomAnchor, topAnchorConstant: 20,
//            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor, leadingAnchorConstant: 10,
//            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor, trailingAnchorConstant: -10
//            )

        tableView.setConstraint(
            topAnchor: mainStack.bottomAnchor, topAnchorConstant: 16,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: 8,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor
        )
    }
    
    @objc private func handleAdd() {
        let vc = FoodSearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FoodInputViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodVC = FoodDetailScreen()
        let food = foods[indexPath.row]
        foodVC.foodId = food.id
        foodVC.foodName = food.name
        
        let vc = UINavigationController(rootViewController: foodVC)
        self.navigationController?.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { (action, view, bool) in
            print("deleted")
        }
        action.image = UIImage(systemName: "trash.fill")
        let swipe = UISwipeActionsConfiguration(actions: [action])
        return swipe
    }
    
}

extension FoodInputViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseIdentifier, for: indexPath) as! FoodCell
        cell.configureCell(foodName: foods[indexPath.row].name, description: foods[indexPath.row].description)
        cell.selectionStyle = .none
        return cell
    }
    
}
