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
    private var totalWater: Int = 0
    
    private var waters: [WaterIntake] = []
    
    var delegate: WaterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetch()
        setupView()
        setupLayout()
    }
    
    func fetch() {
        CoreDataService.shared.getWater { intakes in
            self.totalWater = Int(intakes.map({ $0.amount }).reduce(0.0, +))
                        
            DispatchQueue.main.async {
                self.waterAmount.text = "\(self.totalWater) Cups"
                self.waterProgress.setProgress(progress: self.totalWater)
                if self.totalWater > 5 {
                    self.infoLabel.setFont(text: "Good", weight: .bold, color: Color.green)
                }
            }
        }
        CoreDataService.shared.getWater { (totalWtr) in
            self.waters = totalWtr
           
        }
        
        if HealthKitService.shared.checkAuthorization() {
            HealthKitService.shared.fetchWater { (glassIntake) in
                self.totalWater = Int(glassIntake)
                            
                DispatchQueue.main.async {
                    self.waterAmount.text = "\(self.totalWater) Cups"
                    self.waterProgress.setProgress(progress: self.totalWater)
                    if self.totalWater > 5 {
                        self.infoLabel.setFont(text: "Good", weight: .bold, color: Color.green)
                    }
                }
            }
        }
    }
    
    @objc private func handleDone() {
        delegate?.sendWater(water: totalWater)
        dismiss(animated: true, completion: nil)
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
        waterAmount.setFont(text: "\(totalWater) Cups", size: 34, weight: .bold)
        view.addSubview(waterAmount)
        
        waterProgress = HorizontalProgressView(progress: totalWater)
        view.addSubview(waterProgress)
        
        infoLabel = UILabel()
        infoLabel.setFont(text: "Need more water", size: 17, weight: .bold, color: Color.red)
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
    
}

extension WaterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 14
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WaterCell.reuseIdentifier, for: indexPath) as! WaterCell
        
        if indexPath.row < totalWater {
            cell.image = UIImage(named: "glass_fill")
        } else{
            cell.image = UIImage(named: "glass_empty")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let cell = collectionView.cellForItem(at: indexPath) as? WaterCell {
            if cell.image == UIImage(named: "glass_fill") {
                cell.image = UIImage(named: "glass_empty")
                let water = waters[indexPath.row]
                
               
                
                guard let idCoreData = water.id else { return }
                guard let idWater = water.idWater else { return }
                
                print(idWater)
//                CoreDataService.shared.deleteWater(idCoreData)
                HealthKitService.shared.deleteHealthData(id: idWater, type: .dietaryWater, unit: .cupUS())
                
                totalWater -= 1
                waterAmount.text = "\(totalWater) Cups"
                waterProgress.setProgress(progress: totalWater)
                
            } else {
                let water = HealthKitService.shared.addData(amount: 1, date: Date(), type: .dietaryWater, unit: HKUnit.cupUS())
                print("Air:\(water)")
                
                CoreDataService.shared.addWater(id: UUID(),waterId:water)
                cell.image = UIImage(named: "glass_fill")
                totalWater += 1
                waterAmount.text = "\(totalWater) Cups"
                waterProgress.setProgress(progress: totalWater)
            }
         
        }
        
        fetch()
        
    }
    
}

