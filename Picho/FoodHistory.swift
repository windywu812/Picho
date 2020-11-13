//
//  FoodHistory.swift
//  Picho
//
//  Created by Windy on 13/11/20.
//

import UIKit

class FoodHistory: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        
        delegate = self
        dataSource = self
        isScrollEnabled = false
        rowHeight = 90
        register(FoodHistoryCell.self, forCellReuseIdentifier: FoodHistoryCell.reuseIdentifier)
        
        /// Calculate tableview height
        var totalRow = 0
        for section in 0..<numberOfSections {
            totalRow += numberOfRows(inSection: section)
        }
        let totalHeight = 40 * numberOfSections + totalRow * 90
        
        setConstraint(
            heighAnchorConstant: CGFloat(totalHeight))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FoodHistory: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodHistoryCell.reuseIdentifier) as! FoodHistoryCell
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.setupCell(imageIcon: "breakfast", labelText: "Breakfast", calorie: 431, sugar: 21, satFat: 13, isHead: true)
            }
        case 1:
            if indexPath.row == 0 {
                cell.setupCell(imageIcon: "lunch", labelText: "Lunch", calorie: 431, sugar: 21, satFat: 13, isHead: true)
            }
        case 2:
            if indexPath.row == 0 {
                cell.setupCell(imageIcon: "dinner", labelText: "Dinner", calorie: 431, sugar: 21, satFat: 13, isHead: true)
            }
        default:
            break
        }
        
        if indexPath.row != 0 {
            cell.setupCell(labelText: "Nasi lemak", howOften: 8, calorie: 243, sugar: 33, satFat: 33, isHead: false)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return HeaderView()
        }
        return nil
    }
    
}
