//
//  NotificationViewController.swift
//  Picho
//
//  Created by Windy on 10/11/20.
//

import UIKit
import UserNotifications

class NotificationViewModel {
    
    var notifications: [Notif] = []
    
    init() {
        fetchData()
    }
    
    private func fetchData() {
        CoreDataService.shared.fetchNotificationData { (notifs) in
            self.notifications = notifs
        }
    }
    
    func addToCoreData(id: String, timeLabel: String, isOn: Bool) {
        CoreDataService.shared.addNotification(id: id, isOn: isOn, timeLabel: timeLabel)
    }
    
}

class NotificationViewController: UIViewController {
    
    private var tableView: UITableView!
    private var breakfastTextfield: UITextField!
    private var lunchTextfield: UITextField!
    private var dinnerTextfield: UITextField!
    private var snacksTextfield: UITextField!
    private var waterTextfield: UITextField!
    private var wightInTextfield: UITextField!
    private var reflectionTextfield: UITextField!
    
    private var timeBreakfast: Date?
    private var timeLunch: Date?
    private var timeDinner: Date?
    private var timeSnacks: Date?
    private var timeWater: Date?
    private var timeWight: Date?
    private var timeReflection: Date?
    
    private let viewModel = NotificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notifications"
        setupTableView()
        
        NotificationCenterServices.requestPermission()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(endEditting))
        view.addGestureRecognizer(tap)
        view.backgroundColor = Color.background
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Color.background
        tableView.register(Value1Cell.self, forCellReuseIdentifier: Value1Cell.reuseIdentifier)
        view.addSubview(tableView)
        
        tableView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    @objc func handleSwitch(sender: UISwitch) {
        
        switch sender.tag {
        case 0:
            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: timeBreakfast ?? ("08:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Breakfast",
                title: "Good morning!",
                body: "Start your day with a breakfast, and don’t forget to log it! 😉",
                time: dateComponent, isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Breakfast",
                timeLabel: timeBreakfast?.changeToString() ?? "08:00",
                isOn: sender.isOn)
        case 1:
            let dateComponent = Calendar.current.dateComponents([.hour, .minute], from: timeLunch ?? ("12:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Lunch",
                title: "It's past midday!",
                body: "What did you have for lunch today?",
                time: dateComponent,
                isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Lunch",
                timeLabel: timeLunch?.changeToString() ?? "12:00",
                isOn: sender.isOn)
        case 2:
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeDinner ?? ("07:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Dinner",
                title: "Evening is here!",
                body: "Have you had your dinner? Don’t forget to log it!",
                time: dateComponents,
                isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Dinner",
                timeLabel: timeDinner?.changeToString() ?? "19:00",
                isOn: sender.isOn)
        case 3:
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeSnacks ?? ("16:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Snacks",
                title: "Now is the best time for snacks.",
                body: "Picho loves snack time. What about you?",
                time: dateComponents,
                isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Snacks",
                timeLabel: timeSnacks?.changeToString() ?? "16:00",
                isOn: sender.isOn)
        case 4:
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeSnacks ?? ("12:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Water",
                title: "*Gulp* *gulp* *gulp*",
                body: "Eight glasses of water a day, keeps dehydration away!",
                time: dateComponents,
                isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Water",
                timeLabel: timeBreakfast?.changeToString() ?? "12:00",
                isOn: sender.isOn)
        case 5:
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeSnacks ?? ("12:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Weight In",
                title: "Weight In",
                body: "Have you checked your weight?",
                time: dateComponents,
                isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Weigh In",
                timeLabel: timeBreakfast?.changeToString() ?? "12:00",
                isOn: sender.isOn)
        case 6:
            let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: timeSnacks ?? ("20:00").changeToDate())
            NotificationCenterServices.setupNotification(
                uuid: "Reflection",
                title: "Reflection",
                body: "Check your progress",
                time: dateComponents,
                isOn: sender.isOn)
            viewModel.addToCoreData(
                id: "Reflection",
                timeLabel: timeBreakfast?.changeToString() ?? "20:00",
                isOn: sender.isOn)
        default:
            break
        }
    }
    
    @objc func handleDataPicker(sender: UIDatePicker) {
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "HH:mm"
        
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
    
    @objc private func endEditting() {
        view.endEditing(true)
    }
    
}

extension NotificationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Value1Cell.reuseIdentifier, for: indexPath) as! Value1Cell
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[0].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 0
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                control.isOn = viewModel.notifications[0].isOn
                cell.accessoryView = control
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 0)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                breakfastTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                breakfastTextfield.addStyle(tag: 0, text: viewModel.notifications[0].timeLabel ?? "08:00", datePicker: datePicker)
                cell.accessoryView = breakfastTextfield
                cell.textLabel?.text = ""
            }
        case 1:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[1].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 1
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
                control.isOn = viewModel.notifications[1].isOn
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 1)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                lunchTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                lunchTextfield.addStyle(tag: 1, text: viewModel.notifications[1].timeLabel ?? "12:00", datePicker: datePicker)
                cell.accessoryView = lunchTextfield
                cell.textLabel?.text = ""
            }
        case 2:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[2].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 2
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
                control.isOn = viewModel.notifications[2].isOn
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 2)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                dinnerTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                dinnerTextfield.addStyle(tag: 2, text: viewModel.notifications[2].timeLabel ?? "19:00", datePicker: datePicker)
                cell.accessoryView = dinnerTextfield
                cell.textLabel?.text = ""
            }
        case 3:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[3].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 3
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
                control.isOn = viewModel.notifications[3].isOn
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 3)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                snacksTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                snacksTextfield.addStyle(tag: 3, text: viewModel.notifications[3].timeLabel ?? "16:00", datePicker: datePicker)
                cell.accessoryView = snacksTextfield
                cell.textLabel?.text = ""
            }
        case 4:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[4].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 4
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
                control.isOn = viewModel.notifications[4].isOn
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 4)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                waterTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                waterTextfield.addStyle(tag: 4, text: viewModel.notifications[4].timeLabel ?? "12:00", datePicker: datePicker)
                cell.accessoryView = waterTextfield
                cell.textLabel?.text = ""
            }
        case 5:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[5].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 5
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
                control.isOn = viewModel.notifications[5].isOn
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 5)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                wightInTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                wightInTextfield.addStyle(tag: 5, text: viewModel.notifications[5].timeLabel ?? "12:00", datePicker: datePicker)
                cell.accessoryView = wightInTextfield
                cell.textLabel?.text = ""
            }
        case 6:
            if indexPath.row == 0 {
                cell.textLabel?.setFont(text: viewModel.notifications[6].id ?? "", weight: .bold)
                let control = UISwitch()
                control.tag = 6
                control.addTarget(self, action: #selector(handleSwitch(sender:)), for: .valueChanged)
                cell.accessoryView = control
                control.isOn = viewModel.notifications[6].isOn
            } else {
                let datePicker = UIDatePicker()
                datePicker.setupStyle(tag: 6)
                datePicker.addTarget(self, action: #selector(self.handleDataPicker(sender:)), for: .valueChanged)
                
                reflectionTextfield = UITextField(frame: CGRect(x: 0, y: 0, width: 56, height: 30))
                reflectionTextfield.addStyle(tag: 6, text: viewModel.notifications[6].timeLabel ?? "20:00", datePicker: datePicker)
                cell.accessoryView = reflectionTextfield
                cell.textLabel?.text = ""
            }
        default:
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Remind me to log at"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 5:
            return "Weighing yourself at the same time weekly will give a more accurate weight result"
        case 6:
            return "Reflect on your progress at the same time weekly to understand your current habit and make an informed decision on changes to make for the coming week"
        default:
            return nil
        }
    }
    
}

extension NotificationViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}

extension NotificationViewController: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center:UNUserNotificationCenter, willPresent notification:
                                    UNNotification,withCompletionHandler completionHandler: @escaping
                                        (UNNotificationPresentationOptions) -> Void){
        completionHandler([.sound,.alert])
    }
    
}
