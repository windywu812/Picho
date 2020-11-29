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
    
    var eatingTime: EatTime = .breakfast
    
//    private let foods = [
//        SearchedFood(id: "5873608", name: "Nasi Goreng", description: "Per 1122g - Calories: 1850kcal | Fat: 65.44g | Carbs: 240.17g | Protein: 69.07g", brand: nil, type: "Generic", url: "https://www.fatsecret.com/calories-nutrition/generic/nasi-goreng"),
//        SearchedFood(id: "5873608", name: "Nasi Goreng", description: "Per 1122g - Calories: 1850kcal | Fat: 65.44g | Carbs: 240.17g | Protein: 69.07g", brand: nil, type: "Generic", url: "https://www.fatsecret.com/calories-nutrition/generic/nasi-goreng")
//    ]
    
    private var foods: [DailyIntake] = []
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTable()
        setupLayout()
        fetchData()
        
        setupObservers()
        
        navigationItem.largeTitleDisplayMode = .never
        title = eatingTime.rawValue.capitalized
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
        titleLabel.text = "Would you mind to share your \n\(eatingTime.rawValue) with me?"
        
        addButton = UIButton()
        addButton.backgroundColor = Color.green
        addButton.layer.cornerRadius = 8
        addButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: view.safeAreaInsets.left, bottom: 12, right: view.safeAreaInsets.right)
        addButton.setTitle("Add \(eatingTime.rawValue.capitalized)", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        addButton.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
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

        tableView.setConstraint(
            topAnchor: mainStack.bottomAnchor, topAnchorConstant: 24,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: 8,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor
        )
    }
    
    private func setupObservers() {
        let name = Notification.Name(rawValue: NotificationKey.dailyIntakeKey)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFetching(_:)), name: name, object: nil)
    }
    
    private func fetchData() {
        CoreDataService.shared.getDailyIntake(time: eatingTime, date: Date()) { intakes in
            self.foods = intakes
        }
        
        switch eatingTime {
        case .breakfast:
            UserDefaultService.hasBreakfast = foods.count != 0 ? true : false
        case .lunch:
            UserDefaultService.hasLunch = foods.count != 0 ? true : false
        case .dinner:
            UserDefaultService.hasDinner = foods.count != 0 ? true : false
        case .snacks:
            break
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc private func reloadFetching(_ notification:Notification) {
        fetchData()
    }
    
    @objc private func handleAdd() {
        let vc = FoodSearchViewController()
        vc.eatingTime = eatingTime
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FoodInputViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodVC = FoodDetailScreen()
        let food = foods[indexPath.row]
        foodVC.foodId = food.foodId ?? ""
        foodVC.foodDescription = food.description
        foodVC.foodName = food.name ?? ""
        foodVC.isAddShown = false
        
        let vc = UINavigationController(rootViewController: foodVC)
        self.navigationController?.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { (action, view, bool) in
            let food = self.foods[indexPath.row]
            
            guard let idCoreData = food.id else { return }
            
            if let idSugar = food.idSugar,
               let idCalorie = food.idCalorie,
               let idSatFat = food.idSatFat {
                HealthKitService.shared.deleteHealthData(id: idSugar, type: .dietarySugar, unit: .gram())
                HealthKitService.shared.deleteHealthData(id: idCalorie, type: .dietaryEnergyConsumed, unit: .smallCalorie())
                HealthKitService.shared.deleteHealthData(id: idSatFat, type: .dietaryFatSaturated, unit: .gram())
            }
            
            CoreDataService.shared.deleteDailyIntake(idCoreData)
            NotificationService.shared.post()
            
            tableView.reloadData()
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
        cell.configureCell(
            foodName: foods[indexPath.row].name ?? "",
            calorie: foods[indexPath.row].calorie,
            fat: foods[indexPath.row].saturatedFat,
            sugar: foods[indexPath.row].sugars)
        cell.selectionStyle = .none
        return cell
    }
    
}
