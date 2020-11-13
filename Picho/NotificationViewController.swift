//
//  NotificationViewController.swift
//  Picho
//
//  Created by Windy on 10/11/20.
//

import UIKit
import UserNotifications
class NotificationViewController: UIViewController {
   
    let labelCell = ["Breakfast", "Lunch", "Dinner", "Snacks", "Water", "Weigh In", "Reflection"]
    
    private var tableView: UITableView!
    
    private var breakfastTextfield: UITextField!
    private var lunchTextfield: UITextField!
    private var dinnerTextfield: UITextField!
    private var snacksTextfield: UITextField!
    private var waterTextfield: UITextField!
    private var wightInTextfield: UITextField!
    private var reflectionTextfield: UITextField!
    
    private var timeBreakfast : Date!
    private var timeLunch : Date!
    private var timeDinner : Date!
    private var timeSnacks : Date!
    private var timeWater : Date!
    private var timeWight : Date!
    private var timeReflection : Date!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notifications"
        setupTableView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
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
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
       
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound]){ (granted,error) in}
        let notificationContent = UNMutableNotificationContent()
       
        
        
        switch sender.tag {
        case 0:
            let uuidString = UUID().uuidString
            notificationContent.title = "Good morning"
            notificationContent.body = "Dont Forget to set your breakfast"
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeBreakfast!)
            print(dateComponents)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: uuidString, content: notificationContent, trigger: trigger)
            if sender.isOn {
                
                center.add(request) { (error) in
                    print("oke")
                }
                print(timeBreakfast!)
                print(dateFormat.string(from: timeBreakfast!))
            }else{
                center.removePendingNotificationRequests(withIdentifiers: [uuidString])
            }
        case 1:
            if sender.isOn {
                print(timeLunch!)
                print(dateFormat.string(from: timeLunch!))
            }
        case 2:
            if sender.isOn {
                print(timeDinner!)
                print(dateFormat.string(from: timeDinner!))
            }
        case 3:
            if sender.isOn {
                print(timeSnacks!)
                print(dateFormat.string(from: timeSnacks!))
            }
        case 4:
            if sender.isOn {
                print(timeWater!)
                print(dateFormat.string(from: timeWater!))
            }
        case 5:
            if sender.isOn {
                print(timeWight!)
                print(dateFormat.string(from: timeWight!))
            }
        case 6:
            if sender.isOn {
                print(timeReflection!)
                print(dateFormat.string(from: timeReflection!))
            }
        default:
            break
        }
    }
    @objc func handleDataPicker(sender: UIDatePicker) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        
        print(sender.tag)
        
        switch sender.tag {
        case 0:
            breakfastTextfield.text = dateFormat.string(from: sender.date)
            timeBreakfast = sender.date
        case 1:
            lunchTextfield.text = dateFormat.string(from: sender.date)
            timeLunch = sender.date
        case 2:
            dinnerTextfield.text = dateFormat.string(from: sender.date)
            timeDinner = sender.date
        case 3:
            snacksTextfield.text = dateFormat.string(from: sender.date)
            timeSnacks = sender.date
        case 4:
            waterTextfield.text = dateFormat.string(from: sender.date)
            timeWater = sender.date
        case 5:
            wightInTextfield.text = dateFormat.string(from: sender.date)
            timeWight = sender.date
        case 6:
            reflectionTextfield.text = dateFormat.string(from: sender.date)
            timeReflection = sender.date
        default:
            break
        }
        
    }
    
    @objc private func handleTap() {
        view.endEditing(false)
    }
   
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Value1Cell.reuseIdentifier, for: indexPath) as! Value1Cell
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[0], weight: .bold)
                let control = UISwitch()
                control.tag = 0
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 0
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                breakfastTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                breakfastTextfield.addStyle()
                breakfastTextfield.tag = 0
                breakfastTextfield.text = "08:00"
                breakfastTextfield.inputView = datePicker
                cell.accessoryView = breakfastTextfield
            }
        
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[1], weight: .bold)
                let control = UISwitch()
                control.tag = 1
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 1
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                lunchTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                lunchTextfield.addStyle()
                lunchTextfield.tag = 1
                lunchTextfield.text = "12.00"
                lunchTextfield.inputView = datePicker
                cell.accessoryView = lunchTextfield
            }
        case 2:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[2], weight: .bold)
                let control = UISwitch()
                control.tag = 2
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 2
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                dinnerTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                dinnerTextfield.addStyle()
                dinnerTextfield.tag = 2
                dinnerTextfield.text = "07.00"
                dinnerTextfield.inputView = datePicker
                cell.accessoryView = dinnerTextfield
            }
        case 3:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[3], weight: .bold)
                let control = UISwitch()
                control.tag = 3
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 3
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                snacksTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                snacksTextfield.addStyle()
                snacksTextfield.tag = 3
                snacksTextfield.text = "16.00"
                snacksTextfield.inputView = datePicker
                cell.accessoryView = snacksTextfield
            }
        case 4:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[4], weight: .bold)
                let control = UISwitch()
                control.tag = 4
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 4
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                waterTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                waterTextfield.addStyle()
                waterTextfield.tag = 4
                waterTextfield.text = "12.00"
                waterTextfield.inputView = datePicker
                cell.accessoryView = waterTextfield
            }
        case 5:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[5], weight: .bold)
                let control = UISwitch()
                control.tag = 5
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 5
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                wightInTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                wightInTextfield.addStyle()
                wightInTextfield.tag = 5
                wightInTextfield.text = "12.00"
                wightInTextfield.inputView = datePicker
                cell.accessoryView = wightInTextfield
            }
        case 6:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: labelCell[6], weight: .bold)
                let control = UISwitch()
                control.tag = 6
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.tag = 6
                datePicker.setupStyle()
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                reflectionTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                reflectionTextfield.addStyle()
                reflectionTextfield.tag = 6
                reflectionTextfield.text = "20.00"
                reflectionTextfield.inputView = datePicker
                cell.accessoryView = reflectionTextfield
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
extension NotificationViewController : UNUserNotificationCenterDelegate{
       func userNotificationCenter(_ center:UNUserNotificationCenter, willPresent notification:
           UNNotification,withCompletionHandler completionHandler: @escaping
           (UNNotificationPresentationOptions) -> Void){
           completionHandler([.sound,.alert])
       }
       
   }
