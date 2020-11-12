//
//  FoodDetailScreen.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import UIKit
import HealthKit

class FoodDetailScreen: UITableViewController {
    
    private var calorieHeader: UIView!
    private var nutritionHeader: UIView!
    private var nutritionLabel: UILabel!
    private var servingLabel: UILabel!
    private var calorieLabel: UILabel!
    private var calorieAmount: UILabel!
    
    private var calorieNutrition = 0.0
    private var mainNutritions: [String] = []
    private var fatNutritions: [String] = []
    private var cholesterolNutritions: [String] = []
    private var sodiumNutritions: [String] = []
    private var carbohydrateNutritions: [String] = []
    private var proteinNutritions: [String] = []
    
    private var mainAmounts: [Double] = []
    private var fatAmounts: [Double] = []
    private var cholesterolAmounts: [Double] = []
    private var sodiumAmounts: [Double] = []
    private var carbohydrateAmounts: [Double] = []
    private var proteinAmounts: [Double] = []

    private var nutritions: [[String]] = []
    private var amounts: [[Double]] = []
    
    let healthStore = HKHealthStore()
    
    var foodDescription: String = ""
    var foodName: String = ""
    var foodId: String = "" {
        didSet {
            fetchingFood()
        }
    }
    
    var eatingTime: EatTime = .breakfast
    
    private var isFavorite: Bool = false
    
    override init(style: UITableView.Style = .grouped) {
        super.init(style: style)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        setupView()
        setupLayout()
    }
    
    private func setupLabel() {
        mainNutritions = ["Saturated Fat", "Sugars"]
        fatNutritions = ["Fat", "Saturated Fat", "Trans Fat", "Polysaturated Fat", "Monosaturated Fat"]
        cholesterolNutritions = ["Cholesterol"]
        sodiumNutritions = ["Sodium"]
        carbohydrateNutritions = ["Carbohydrate", "Fiber", "Sugars"]
        proteinNutritions = ["Protein"]
        
        nutritions = [mainNutritions, fatNutritions, cholesterolNutritions, sodiumNutritions, carbohydrateNutritions, proteinNutritions]
    }

    private func setupView() {
        view.backgroundColor = Color.background
        
        calorieHeader = UIView()
        
        calorieLabel = UILabel()
        calorieLabel.text = "Calories"
        calorieLabel.font = .preferredFont(forTextStyle: .title2)
        calorieLabel.font = .boldSystemFont(ofSize: 24)

        calorieAmount = UILabel()
        calorieAmount.text = "324"
        calorieAmount.font = .systemFont(ofSize: 34, weight: .bold)
        
        nutritionHeader = UIView()
        
        nutritionLabel = UILabel()
        nutritionLabel.text = "Nutritional Information"
        nutritionLabel.font = .systemFont(ofSize: 26, weight: .bold)
        nutritionHeader.addSubview(nutritionLabel)
        
        servingLabel = UILabel()
        servingLabel.text = "Per serve"
        servingLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nutritionHeader.addSubview(servingLabel)
        
        navigationItem.title = "Nasi Lemak"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(handleAdd))
        
        setupFavorite()
        
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupLayout() {
        let calorieStack = UIStackView(arrangedSubviews: [calorieLabel, calorieAmount])
        calorieStack.axis = .vertical
        calorieStack.alignment = .leading
        calorieStack.spacing = 8
        calorieHeader.addSubview(calorieStack)
        
        calorieStack.setConstraint(
            topAnchor: calorieHeader.topAnchor, topAnchorConstant: 16,
            bottomAnchor: calorieHeader.bottomAnchor, bottomAnchorConstant: -16,
            leadingAnchor: calorieHeader.leadingAnchor, leadingAnchorConstant: 18)

        nutritionLabel.setConstraint(
            topAnchor: nutritionHeader.layoutMarginsGuide.topAnchor,
            leadingAnchor: nutritionHeader.layoutMarginsGuide.leadingAnchor, leadingAnchorConstant: 12)

        servingLabel.setConstraint(
            topAnchor: nutritionLabel.bottomAnchor, topAnchorConstant: 8,
            bottomAnchor: nutritionHeader.bottomAnchor, bottomAnchorConstant: -8,
            trailingAnchor: nutritionHeader.trailingAnchor, trailingAnchorConstant: -20)
    }
    
    private func setupFavorite() {
        let heart = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heart?.withTintColor(.red, renderingMode: .alwaysTemplate)
        
        let favoriteBarButton = UIBarButtonItem(image: heart, style: .done, target: self, action: #selector(handleFavoriteAdd))
        favoriteBarButton.tintColor = .red
        
        navigationItem.leftBarButtonItem = favoriteBarButton
    }
    
    @objc private func handleFavoriteAdd() {
        isFavorite = !isFavorite
        setupFavorite()
    }

    @objc private func handleAdd() {
//        NetworkService.shared.getFood(id: foodId) { food in
//            switch food {
//            case .success(let food):
//                guard let servings = food.servings?.first else { return }
//
//                HealthKitService.addData(sugar: Double(servings.saturatedFat ?? "0") ?? 0, date: Date(), type: .dietaryFatSaturated, unit: HKUnit.gram())
//                HealthKitService.addData(sugar: Double(servings.sugar ?? "0") ?? 0, date: Date(), type: .dietarySugar, unit: HKUnit.gram())
//                HealthKitService.addData(sugar: Double(servings.calories ?? "0") ?? 0, date: Date(), type: .dietaryEnergyConsumed, unit: HKUnit.smallCalorie())
//
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
//        }
        
        if !mainAmounts.isEmpty {
            CoreDataService.shared.addDailyIntake(id: UUID(), foodId: foodId, name: foodName, description: foodDescription, calorie: calorieNutrition, saturatedFat: mainAmounts[0], sugars: mainAmounts[1], time: eatingTime)
        }

        self.navigationController?.popToRootViewController(animated: true)
    }

    private func fetchingFood() {
        NetworkService.shared.getFood(id: foodId) { food in
            switch food {
            case .success(let food):
                guard let servings = food.servings?.first else { return }
                
                DispatchQueue.main.async {
                    self.navigationItem.title = self.foodName
                    
                    self.calorieNutrition = servings.calories.convertToDouble()
                    self.calorieAmount.text = String(self.calorieNutrition)
                    
                    self.mainAmounts.append(servings.saturatedFat.convertToDouble())
                    self.mainAmounts.append(servings.sugar.convertToDouble())
                    
                    self.fatAmounts.append(servings.fat.convertToDouble())
                    self.fatAmounts.append(servings.saturatedFat.convertToDouble())
                    self.fatAmounts.append(servings.transFat.convertToDouble())
                    self.fatAmounts.append(servings.polyunsaturatedFat.convertToDouble())
                    self.fatAmounts.append(servings.monounsaturatedFat.convertToDouble())
                    
                    self.cholesterolAmounts.append(servings.cholesterol.convertToDouble())
                    
                    self.sodiumAmounts.append(servings.sodium.convertToDouble())
                    
                    self.carbohydrateAmounts.append(servings.carbohydrate.convertToDouble())
                    self.carbohydrateAmounts.append(servings.fiber.convertToDouble())
                    self.carbohydrateAmounts.append(servings.sugar.convertToDouble())
                    
                    self.proteinAmounts.append(servings.protein.convertToDouble())
                    
                    self.amounts = [self.mainAmounts, self.fatAmounts, self.cholesterolAmounts, self.sodiumAmounts, self.carbohydrateAmounts, self.proteinAmounts]
                    
                    self.tableView.reloadData()
                }
        
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return nutritions.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return calorieHeader
        case 2:
            return nutritionHeader
        default:
            return UIView()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutritions[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as! DetailCell
        
        let nutrition = nutritions[indexPath.section][indexPath.row]
        var amount = 0.0
        
        if !amounts.isEmpty {
            amount = amounts[indexPath.section][indexPath.row]
        }
        
        cell.configureCell(label: nutrition, value: amount)
        
        return cell
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
