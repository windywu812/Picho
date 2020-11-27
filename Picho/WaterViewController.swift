//
//  WaterViewController.swift
//  Picho
//
//  Created by Windy on 12/11/20.
//


import UIKit
import HealthKit

protocol WaterDelegate {
    func sendWater(water: Int)
}

class WaterViewController: UIViewController {
    
    let detail = """
    Dehydration cause the buildup of ‘bad’ LDL (low-density lipoprotein) cholesterol in our blood stream and also damage cell walls of arteries.

    Drinking enough water makes it easier for your blood to move in your body. And this will help our body to clear the ‘bad’ cholesterol more quickly!
    """
    
    private var detailLabel: UILabel!
    private var waterLabel: UILabel!
    private var waterAmount: UILabel!
    private var waterProgress: HorizontalProgressView!
    private var infoLabel: UILabel!
    private var waterCollectionView: UICollectionView!
    private var waters: [WaterIntake] = []
    
    var delegate: WaterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        fetch()
    }
    
    private func fetch() {
        CoreDataService.shared.getWater { waters in
            self.waters = waters
            DispatchQueue.main.async {
                self.waterAmount.setFont(text: "\(waters.count) Cups", size: 34, weight: .bold)
                self.waterProgress.setProgress(progress: waters.count)
                if waters.count > 5 {
                    self.infoLabel.setFont(text: "Good", weight: .bold, color: Color.green)
                } else {
                    self.infoLabel.setFont(text: "Need more water", weight: .bold, color: Color.red)
                }
            }
        }
        
        waterCollectionView.reloadData()
    }
    
    private func setupView() {
        
        navigationItem.title = "Water"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        view.backgroundColor = Color.background
        
        detailLabel = UILabel()
        detailLabel.text = detail
        detailLabel.numberOfLines = 0
        view.addSubview(detailLabel)
        
        waterLabel = UILabel()
        waterLabel.setFont(text: "Water Intake", weight: .bold)
        view.addSubview(waterLabel)
        
        waterAmount = UILabel()
        view.addSubview(waterAmount)
        
        waterProgress = HorizontalProgressView()
        view.addSubview(waterProgress)
        
        infoLabel = UILabel()
        infoLabel.setFont(text: "Need more water", weight: .bold, color: Color.red)
        view.addSubview(infoLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 43, height: 60)
        
        waterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        waterCollectionView.backgroundColor = Color.background
        waterCollectionView.register(WaterCell.self, forCellWithReuseIdentifier: WaterCell.reuseIdentifier)
        waterCollectionView.delegate = self
        waterCollectionView.dataSource = self
        waterCollectionView.showsHorizontalScrollIndicator = false
        view.addSubview(waterCollectionView)
    }
    
    private func setupLayout() {
        detailLabel.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        waterLabel.setConstraint(
            topAnchor: detailLabel.bottomAnchor, topAnchorConstant: 32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor)
        
        waterAmount.setConstraint(
            topAnchor: waterLabel.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor)
        
        waterProgress.setConstraint(
            topAnchor: waterAmount.bottomAnchor, topAnchorConstant: 16,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor,
            heighAnchorConstant: 10)
        
        infoLabel.setConstraint(
            topAnchor: waterProgress.bottomAnchor, topAnchorConstant: 8,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
        
        waterCollectionView.setConstraint(
            topAnchor: infoLabel.bottomAnchor, topAnchorConstant: 32,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, bottomAnchorConstant: -32,
            leadingAnchor: view.layoutMarginsGuide.leadingAnchor,
            trailingAnchor: view.layoutMarginsGuide.trailingAnchor)
    }
    
    @objc private func handleDone() {
        delegate?.sendWater(water: waters.count)
        dismiss(animated: true, completion: nil)
    }
    
}

extension WaterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterCell.reuseIdentifier, for: indexPath) as! WaterCell
        
        if indexPath.row < waters.count {
            cell.image = UIImage(named: "glass_fill")
            cell.idCoreData = waters[indexPath.row].id
            cell.idHealthKit = waters[indexPath.row].idWater
        } else {
            cell.image = UIImage(named: "glass_empty")
            cell.idCoreData = nil
            cell.idHealthKit = nil
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! WaterCell
        
        if cell.image == UIImage(named: "glass_fill") {
            
            guard let idCoreData = waters[indexPath.row].id,
                  let idHealhKit = waters[indexPath.row].idWater
            else { return }
            
            CoreDataService.shared.deleteWater(id: idCoreData)
            HealthKitService.shared.deleteHealthData(id: idHealhKit, type: .dietaryWater, unit: .cupUS())
            cell.image = UIImage(named: "glass_empty")
            
        } else {
            let water = HealthKitService.shared.addData(amount: 1, date: Date(), type: .dietaryWater, unit: HKUnit.cupUS())
            
            CoreDataService.shared.addWater(id: UUID(), waterId: water)
            cell.image = UIImage(named: "glass_fill")
        }
        
        fetch()
    }
    
}

