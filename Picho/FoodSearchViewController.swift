//
//  FoodSearchViewController.swift
//  Picho
//
//  Created by Wendy Kurniawan on 09/11/20.
//

import UIKit
import Combine

class FoodSearchViewController: UIViewController {
    
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var segmentedControl: UISegmentedControl!
    private var currentSegment = 0
    private var cancelable = Set<AnyCancellable>()
    
    @Published private var foods: [SearchedFood] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupLayout()
        setupSearchBar()
    }
    
    private func setupView() {
        view.backgroundColor = Color.background
        navigationItem.title = "Search"
        
        searchBar = UISearchBar()
        searchBar.placeholder = "Search for a food"
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        
        segmentedControl = UISegmentedControl(items: ["Recent", "Favorites"])
        segmentedControl.selectedSegmentIndex = currentSegment
        segmentedControl.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    private func setupTableView() {
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
        searchBar.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor, leadingAnchorConstant: 10,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor, trailingAnchorConstant: -10
        )
        
        segmentedControl.setConstraint(
            topAnchor: searchBar.bottomAnchor, topAnchorConstant: 10,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor
        )
            
        tableView.setConstraint(
            topAnchor: segmentedControl.bottomAnchor, topAnchorConstant: 16,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            trailingAnchor: view.trailingAnchor)
    }
    
    private func setupSearchBar() {
        let foods = [
            SearchedFood(id: "5873608", name: "Nasi Goreng", description: "Per 1122g - Calories: 1850kcal | Fat: 65.44g | Carbs: 240.17g | Protein: 69.07g", brand: nil, type: "Generic", url: "https://www.fatsecret.com/calories-nutrition/generic/nasi-goreng"),
            SearchedFood(id: "5873608", name: "Nasi Goreng", description: "Per 1122g - Calories: 1850kcal | Fat: 65.44g | Carbs: 240.17g | Protein: 69.07g", brand: nil, type: "Generic", url: "https://www.fatsecret.com/calories-nutrition/generic/nasi-goreng")
        ]
        self.foods = foods
        
//        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
//            .map({ ($0.object as! UISearchTextField).text })
//            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
//            .filter({ !$0!.isEmpty })
//            .sink { text in
//                guard let text = text else { return }
//                NetworkService.shared.searchFood(keyword: text) { (result) in
//                    switch result {
//                    case .success(let foods):
//                        self.foods = foods
//                    case .failure(let err):
//                        self.foods = []
//                        print(err.localizedDescription)
//                    }
//                }
//            }
//            .store(in: &cancelable)
//
//        $foods
//            .sink { (_) in
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }.store(in: &cancelable)
    }
    
    @objc private func handleSegmentChange() {
        print(segmentedControl.selectedSegmentIndex)
    }
}

extension FoodSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseIdentifier, for: indexPath) as! FoodCell
        cell.configureCell(foodName: foods[indexPath.row].name, description: foods[indexPath.row].description)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodVC = FoodDetailScreen()
        let food = foods[indexPath.row]
        foodVC.foodId = food.id
        foodVC.foodName = food.name
        
        let vc = UINavigationController(rootViewController: foodVC)
        self.navigationController?.present(vc, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
