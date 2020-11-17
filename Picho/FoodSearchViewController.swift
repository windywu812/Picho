//
//  FoodSearchViewController.swift
//  Picho
//
//  Created by Wendy Kurniawan on 09/11/20.
//

import UIKit
import Combine

class FoodSearchViewController: UIViewController {
    
    @Published private var foods: [SearchedFood] = []
    private var searchBar: UISearchBar!
    private var tableView: UITableView!
    private var segmentedControl: UISegmentedControl!
    private var currentSegment = 0
    private var cancelable = Set<AnyCancellable>()
    private var favorites: [Favorite] = []
    
    var eatingTime: EatTime =  .breakfast
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupLayout()
        setupSearchBar()
        setupObservers()
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
    
    private func setupSearchBar() {
        
        NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchBar.searchTextField)
            .map({ ($0.object as! UISearchTextField).text })
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .filter({ !$0!.isEmpty })
            .sink { text in
                guard let text = text else { return }
                NetworkService.shared.searchFood(keyword: text) { (result) in
                    switch result {
                    case .success(let foods):
//                        print(foods.first?.servings)
                        self.foods = foods
                    case .failure(let err):
                        self.foods = []
                        print(err.localizedDescription)
                    }
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
            setupSearchBar()
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
            cell.configureCell(foodName: foods[indexPath.row].name, description: foods[indexPath.row].description)
        case 1:
            cell.configureCell(foodName: favorites[indexPath.row].name ?? "", description: favorites[indexPath.row].desc ?? "")
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
            foodVC.foodId = food.id
            foodVC.foodName = food.name
            foodVC.foodDescription = food.description
            foodVC.eatingTime = eatingTime
        case 1:
            let food = favorites[indexPath.row]
            foodVC.foodId = food.id ?? ""
            foodVC.foodName = food.name ?? ""
            foodVC.foodDescription = food.desc ?? ""
            foodVC.isFavorite = true
            foodVC.eatingTime = eatingTime
        default:
            break
        }
        
        let vc = UINavigationController(rootViewController: foodVC)
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
}
