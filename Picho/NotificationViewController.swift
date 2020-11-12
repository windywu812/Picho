//
//  NotificationViewController.swift
//  Picho
//
//  Created by Windy on 10/11/20.
//

import UIKit

class NotificationViewController: UIViewController {
   
    let labelCell = ["Breakfast", "Lunch", "Dinner", "Snacks", "Water", "Weigh In", "Reflection"]
    private let datePicker: UIDatePicker = {
        let datePick = UIDatePicker()
        datePick.datePickerMode = .time
        if #available(iOS 13.4, *) {
            datePick.preferredDatePickerStyle = .wheels
        }
        return datePick
    }()
    
    
    
    private var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notifications"
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(Value1Cell.self, forCellReuseIdentifier: Value1Cell.reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    @objc func handleSwitch(sender: UISwitch) {
        print(sender.tag)
        print(sender.isOn)
    }
    @objc func handleDataPicker(sender: UIDatePicker) {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        switch sender.tag {
        case 0:
           func handleTextField(sender2: UITextField) {
//                sender2.viewWithTag(0).text = dateFormat.string(from: sender.date)
                sender2.text = dateFormat.string(from: sender.date)
            }
            
        case 1:
            func handleTextField(sender2: UITextField) {
 //                sender2.viewWithTag(0).text = dateFormat.string(from: sender.date)
                 sender2.text = dateFormat.string(from: sender.date)
             }
        default:
            break
        }
        
        print(sender.tag)
        
//        if let dateTextField = startDateTextField.viewWithTag(sender.tag) as? UITextField {
//            dateTextField.text = dateFormat.string(from: sender.date)
//        }
        
    }
   

    
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Value1Cell.reuseIdentifier, for: indexPath) as! Value1Cell
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[0], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 0
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
               
                let startDateTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 55, height: 30))
                startDateTextField.layer.cornerRadius = 5.0
                startDateTextField.layer.borderColor = Color.green.cgColor
                startDateTextField.layer.borderWidth = 2.0
                startDateTextField.tag = 0
                startDateTextField.addPadding(padding: .equalSpacing(5))
                startDateTextField.inputView = datePicker
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                cell.accessoryView = startDateTextField
            }
        
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[1], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 1
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
               let startDateTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 55, height: 30))
                startDateTextField.layer.cornerRadius = 5.0
                startDateTextField.layer.borderColor = Color.green.cgColor
                startDateTextField.layer.borderWidth = 2.0
                startDateTextField.addPadding(padding: .equalSpacing(5))
                startDateTextField.inputView = datePicker
                startDateTextField.tag = 1
//                datePicker.tag =
//                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender: datePicker, textField:startDateTextField)), for: .valueChanged)
                
                datePicker.addTarget (self, action: #selector (self.handleDataPicker(sender:)), for: .valueChanged)
                
                cell.accessoryView = startDateTextField
            }
        case 2:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[2], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 2
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            }
            
        case 3:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[3], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 3
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            }
        case 4:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[4], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 4
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            }
        case 5:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[5], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 5
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            }
        case 6:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[6], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 6
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            }
        case 7:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[7], size: 17, weight: .bold)
                let control = UISwitch()
                control.tag = 7
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            }
        default:
            break
        }
        
        if indexPath.row == 1 {
            cell.textLabel?.text = "Remind me at"
        }
        cell.imageView?.image = UIImage(systemName: "person")
        cell.selectionStyle = .none
        return cell
    }


    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
