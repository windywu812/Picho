//
//  FoodSearchViewController.swift
//  Picho
//
//  Created by Wendy Kurniawan on 09/11/20.
//

import UIKit
import Combine

class FoodSearchViewController: UIViewController {
    
    @Published private var foods: [FoodDetail] = []
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var segmentedControl: UISegmentedControl!
    private var currentSegment = 0
    private var cancelable = Set<AnyCancellable>()
    private var favorites: [Favorite] = []
    
    var eatingTime: EatTime =  .breakfast
    
    private let viewModel = FoodSearchViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupLayout()
        setupBinding()
        setupObservers()
        fetchAllData()
    }
    
    private func setupView() {
        view.backgroundColor = Color.background
        navigationItem.title = NSLocalizedString("Search", comment: "")
        
        searchBar = UISearchBar()
        searchBar.placeholder = NSLocalizedString( "Search for a food", comment: "")
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        
        segmentedControl = UISegmentedControl(items: [NSLocalizedString("Recent", comment: "") ,NSLocalizedString("Favorites", comment: "") ])
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
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor, leadingAnchorConstant: 12,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor, trailingAnchorConstant: -11
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
    
    private func setupBinding() {
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
            .map({ ($0.object as! UISearchTextField).text })
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .sink { text in
                if text?.count != 0 {
                    APIService.fetchApi(with: .searchFood(text!), response: [FoodDetail].self) { (result) in
                        switch result {
                        case .success(let foods):
                            print(foods.count)
                            self.foods = foods
                        case .failure(let err):
                            self.foods = []
                            print(err.localizedDescription)
                        }
                    }
                } else {
                    self.fetchAllData()
                }
            }
            .store(in: &cancelable)

        $foods
            .sink { (_) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }.store(in: &cancelable)
    }
    
    private func fetchAllData() {
        APIService.fetchApi(with: .getAllFood, response: [FoodDetail].self) {  (result) in
            switch result {
            case .success(let foods):
                print(foods.count)
                self.foods = foods
            case .failure(let err):
                self.foods = []
                print(err.localizedDescription)
            }
        }
    }
    
    private func fetchFavorite() {
        CoreDataService.shared.getFavorite { favorites in
            self.favorites = favorites
        }
    }
    
    @objc private func reloadFetching(_ notification: Notification) {
        fetchFavorite()
        tableView.reloadData()
    }
    
    private func setupObservers() {
        let name = Notification.Name(rawValue: NotificationKey.favoriteKey)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFetching(_:)), name: name, object: nil)
    }
    
    @objc private func handleSegmentChange() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            setupBinding()
        case 1:
            fetchFavorite()
        default:
            print("Out of index")
        }
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension FoodSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return foods.count
        case 1:
            return favorites.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.reuseIdentifier, for: indexPath) as! FoodCell
        cell.selectionStyle = .none
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.configureCell(
                foodName: foods[indexPath.row].nameId,
                calorie: foods[indexPath.row].calories,
                fat: foods[indexPath.row].saturatedFat,
                sugar: foods[indexPath.row].sugar)
        case 1:
            cell.configureCell(
                foodName: favorites[indexPath.row].name ?? "No Name",
                calorie: favorites[indexPath.row].calorie,
                fat: favorites[indexPath.row].satFat,
                sugar: favorites[indexPath.row].sugar)
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodVC = FoodDetailScreen()
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            let food = foods[indexPath.row]
            foodVC.foodId = String(food.foodId)
            foodVC.eatingTime = eatingTime
        case 1:
            let food = favorites[indexPath.row]
            foodVC.foodId = String(food.id ?? "0")
            foodVC.eatingTime = eatingTime
        default:
            break
        }
        
        let vc = UINavigationController(rootViewController: foodVC)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}

