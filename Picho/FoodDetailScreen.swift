//
//  FoodDetailScreen.swift
//  iChol
//
//  Created by Windy on 02/11/20.
//

import UIKit
import Combine
import HealthKit

class FoodDetailScreen: UITableViewController {
    
    var isAddShown = true
    var foodId: String = "" {
        didSet {
            fetchingFood()
        }
    }
    var eatingTime: EatTime = .breakfast
    var isFavorite: Bool = false
    
    private var viewModel = FoodDetailViewModel()
    private var headerName: FoodNameHeader?
    
    private var servingTextfield: UITextField!
    
    var food: FoodDetail?
    var containerFood: FoodDetail?
    var nutritionAmount: [[Double]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupFavorite()
        fetchingFavorite()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(tap)
    }
    
    private func setupView() {
        view.backgroundColor = Color.background
        
        calorieHeader = UIView()
        
        calorieLabel = UILabel()
        calorieLabel.text = NSLocalizedString("Calories", comment: "")
        calorieLabel.font = .preferredFont(forTextStyle: .title2)
        calorieLabel.font = .boldSystemFont(ofSize: 24)

        calorieAmount = UILabel()
        calorieAmount.text = "324"
        calorieAmount.font = .systemFont(ofSize: 34, weight: .bold)
        
        nutritionHeader = UIView()
        
        nutritionLabel = UILabel()
        nutritionLabel.text = NSLocalizedString("Nutritional Information", comment: "")
        nutritionLabel.font = .systemFont(ofSize: 26, weight: .bold)
        nutritionHeader.addSubview(nutritionLabel)
        
        servingLabel = UILabel()
        servingLabel.text = NSLocalizedString("Per serve", comment: "")
        servingLabel.font = .systemFont(ofSize: 17, weight: .bold)
        nutritionHeader.addSubview(servingLabel)
        
        navigationItem.title = "Nasi Lemak"
        navigationItem.rightBarButtonItem = isAddShown ? UIBarButtonItem(title:NSLocalizedString("Add", comment: ""), style: .done, target: self, action: #selector(handleAdd)) : nil

        
        tableView.register(DetailCell.self, forCellReuseIdentifier: DetailCell.reuseIdentifier)
        tableView.register(ServingCell.self, forCellReuseIdentifier: ServingCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupFavorite() {
        let heart = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        heart?.withTintColor(.red, renderingMode: .alwaysTemplate)
        
        let favoriteBarButton = UIBarButtonItem(image: heart, style: .done, target: self, action: #selector(handleFavoriteAdd))
        favoriteBarButton.tintColor = .red
        
        navigationItem.leftBarButtonItem = favoriteBarButton
    }
    
    private func checkFavorite () {
        if !isFavorite {
            CoreDataService.shared.addFavorite(
                id: foodId,
                name: food?.nameId ?? "",
                sugar: food?.sugar ?? 0,
                calorie: food?.calories ?? 0,
                satFat: food?.saturatedFat ?? 0)
        } else {
            CoreDataService.shared.deleteFavorite(foodId)
        }
        NotificationService.shared.post(with: NotificationKey.favoriteKey)
    }
    
    @objc private func handleFavoriteAdd() {
        checkFavorite()
        isFavorite.toggle()
        setupFavorite()
    }
    
    @objc private func handleAdd() {
        
        let idSatFat = HealthKitService.shared.addData(
            amount: Double(food?.saturatedFat ?? 0),
            date: Date(),
            type: .dietaryFatSaturated,
            unit: HKUnit.gram())
        let idSugar = HealthKitService.shared.addData(
            amount: Double(food?.sugar ?? 0),
            date: Date(),
            type: .dietarySugar,
            unit: HKUnit.gram())
        let idCalorie = HealthKitService.shared.addData(
            amount: Double(food?.calories ?? 0),
            date: Date(),
            type: .dietaryEnergyConsumed,
            unit: HKUnit.smallCalorie())
        
        guard let food = food else { return }
        
        CoreDataService.shared.addDailyIntake(
            id: UUID(),
            foodId: String(food.foodId),
            name: food.nameId,
            calorie: food.calories,
            saturatedFat: food.saturatedFat,
            sugars: food.sugar,
            date: Date(),
            idCalorie: idCalorie,
            idSugar: idSugar,
            idSatFat: idSatFat,
            time: eatingTime)
        
        NotificationService.shared.post()
        
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchingFood() {
        APIService.fetchApi(with: .getDetail(Int(foodId) ?? 0), response: FoodDetail.self) { (result) in
            switch result {
            case .success(let response):
                self.food = response
                self.containerFood = response
                
                let section1Amount = [self.food?.calories, self.food?.saturatedFat, self.food?.sugar].compactMap({ $0 })
                let section2Amount = [self.food?.serving].compactMap({ $0 })
                let section3Amount = [self.food?.totalFat, self.food?.calorieFromFat, self.food?.transFat, self.food?.cholesterol].compactMap({ $0 })
                let section4Amount = [self.food?.cholesterol, self.food?.protein, self.food?.fiber, self.food?.sodium, self.food?.calcium, self.food?.iron].compactMap({ $0 })
                let section5Amount = [self.food?.vitaminA, self.food?.vitaminC].compactMap({ $0 })
                self.nutritionAmount = [section1Amount, section2Amount, section3Amount, section4Amount, section5Amount]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func fetchingFavorite() {
        CoreDataService.shared.getFavorite(for: foodId) { favorites in
            self.isFavorite = !favorites.isEmpty
        }
        setupFavorite()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.labels.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            headerName = FoodNameHeader()
            headerName?.nameLabel.text = food?.nameId
            return headerName
        case 2:
            return NutrionalHeader()
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 4 {
            return SourceFooter()
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.labels[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.reuseIdentifier, for: indexPath) as! DetailCell
        
        if nutritionAmount.isEmpty { return cell }
        
        cell.configureCell(
            label: viewModel.labels[indexPath.section][indexPath.row],
            value: nutritionAmount[indexPath.section][indexPath.row])
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServingCell.reuseIdentifier, for: indexPath) as! ServingCell
            cell.servingTf.text = "\(Int(nutritionAmount[indexPath.section][indexPath.row]))"
            cell.servingTf.isEnabled = isAddShown ? true : false
            cell.parent = self
            
            return cell
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override init(style: UITableView.Style = .grouped) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleDismiss() {
        view.endEditing(true)
    }
    
}

class ServingCell: UITableViewCell {
    
    static let reuseIdentifier = "ServingCell"
    
    private var cancelable = Set<AnyCancellable>()
    var servingTf: UITextField!
    
    var parent: FoodDetailScreen?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        textLabel?.text = "Serving Size"
        detailTextLabel?.text = ""
        
        let unit = UILabel()
        unit.text = "g"
        unit.textColor = .secondaryLabel
        
        servingTf = UITextField()
        servingTf.textAlignment = .right
        servingTf.textColor = .secondaryLabel
        servingTf.keyboardType = .numberPad
        
        let mainStack = UIStackView(arrangedSubviews: [servingTf, unit])
        mainStack.spacing = 4
        addSubview(mainStack)
        
        mainStack.setConstraint(
            trailingAnchor: layoutMarginsGuide.trailingAnchor, trailingAnchorConstant: -16,
            centerYAnchor: centerYAnchor,
            heighAnchorConstant: 30,
            widthAnchorConstant: 100)
        
        NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: servingTf)
            .map({ (($0.object as! UITextField).text ?? "") })
            .filter({ !$0.isEmpty })
            .sink { text in
                if !text.isEmpty {
                    let serving = (Double(text) ?? 100) / 100
                    
                    guard let food = self.parent?.containerFood else { return }
                    
                    let newData = FoodDetail(
                        foodId: food.foodId,
                        nameId: food.nameId,
                        nameEn: food.nameEn,
                        serving: serving,
                        calories: food.calories * serving,
                        calorieFromFat: food.calorieFromFat * serving,
                        totalFat: food.totalFat * serving,
                        saturatedFat: food.saturatedFat * serving,
                        transFat: food.transFat * serving,
                        cholesterol: food.cholesterol * serving,
                        sodium: food.sodium * serving,
                        totalCarbs: food.totalCarbs * serving,
                        fiber: food.fiber * serving,
                        sugar: food.sugar * serving,
                        protein: food.protein * serving,
                        vitaminA: food.vitaminA * serving,
                        calcium: food.calcium * serving,
                        vitaminC: food.vitaminC * serving,
                        iron: food.iron * serving)
                    self.parent?.food = newData
                    
                    let section1Amount = [newData.calories, newData.saturatedFat, newData.sugar]
                    let section2Amount = [newData.serving]
                    let section3Amount = [newData.totalFat, newData.calorieFromFat, newData.transFat, newData.cholesterol]
                    let section4Amount = [newData.cholesterol, newData.protein, newData.fiber, newData.sodium, newData.calcium, newData.iron]
                    let section5Amount = [newData.vitaminA, newData.vitaminC]
                    self.parent?.nutritionAmount = [section1Amount, section2Amount, section3Amount, section4Amount, section5Amount]
                    
                    self.parent?.tableView.reloadSections(IndexSet(arrayLiteral: 0, 2, 3, 4), with: .automatic)
                }
            }
            .store(in: &cancelable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


