//
//  ProfileEditViewController.swift
//  Picho
//
//  Created by Windy on 15/11/20.
//

import UIKit

class ProfileEditViewController: UIViewController, UINavigationControllerDelegate {
    
    private var imageProfile: UIImageView!
    private var editButton: UIButton!
    private var tableView: UITableView!
    private var scrollView: UIScrollView!
    private var genderPicker: UIPickerView!
    
    private var nameTextField: UITextField!
    private var genderTextField: UITextField!
    private var ageTextField: UITextField!
    private var heightTextField: UITextField!
    private var weightTextField: UITextField!
    
    let viewModel = ProfileViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewModel.fetchUserDefault()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Edit"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        setupView()
        setupPicker()
        setupTableView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleDismiss))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func handleDone() {
        UserDefaultService.name = nameTextField.text ?? ""
        UserDefaultService.gender = genderTextField.text ?? ""
        UserDefaultService.age = ageTextField.text ?? ""
        UserDefaultService.height = heightTextField.text ?? ""
        UserDefaultService.weight = weightTextField.text ?? ""
        viewModel.savePic(image: (imageProfile.image ?? UIImage(systemName: "person.circle"))!, key: UserDefaultService.photoProfileKey)
        UserDefaultService.synchronize()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleDismiss() {
        view.endEditing(true)
    }
    
    private func setupPicker() {
        genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
    }
    
}

extension ProfileEditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Value1Cell.reuseIdentifier) as! Value1Cell
        cell.selectionStyle = .none
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Name"
            nameTextField = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
            nameTextField.removeBorder(tag: 0, text: viewModel.fullName)
            nameTextField.keyboardType = .default
            cell.accessoryView = nameTextField
        case 1:
            cell.textLabel?.text = viewModel.secondSectionLabel[indexPath.row]
            switch indexPath.row {
            case 0:
                genderTextField = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
                genderTextField.removeBorder(tag: 1, text: viewModel.secondSection[0])
                genderTextField.inputView = genderPicker
                cell.accessoryView = genderTextField
            case 1:
                ageTextField = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
                ageTextField.removeBorder(tag: 2, text: viewModel.secondSection[1])
                cell.accessoryView = ageTextField
            case 2:
                heightTextField = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
                heightTextField.removeBorder(tag: 3, text: viewModel.secondSection[2])
                cell.accessoryView = heightTextField
            case 3:
                weightTextField = UITextField(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
                weightTextField.removeBorder(tag: 4, text: viewModel.secondSection[3])
                cell.accessoryView = weightTextField
            default:
                break
            }
        default:
            break
        }
        return cell
    }
}

extension ProfileEditViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "Male"
        } else {
            return "Female"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            genderTextField.text = "Male"
        } else {
            genderTextField.text = "Female"
        }
    }
}

extension ProfileEditViewController {
    
    private func setupView() {
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = Color.background
        view.addSubview(scrollView)
        
        scrollView.setConstraint(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: view.safeAreaLayoutGuide.leadingAnchor,
            trailingAnchor: view.safeAreaLayoutGuide.trailingAnchor)
        
        imageProfile = UIImageView()
        if viewModel.getPic(forKey: UserDefaultService.photoProfileKey) == nil {
            imageProfile.image = UIImage(systemName: "person.circle")
        } else {
            imageProfile.image = viewModel.getPic(forKey: UserDefaultService.photoProfileKey)
        }
        scrollView.addSubview(imageProfile)
        
        imageProfile.setConstraint(
            topAnchor: scrollView.topAnchor, topAnchorConstant: 32,
            centerXAnchor: view.centerXAnchor,
            heighAnchorConstant: 120, widthAnchorConstant: 120)
        
        editButton = UIButton(type: .system)
        editButton.setAttributedTitle(NSAttributedString.bodyFont(text: "Edit", color: Color.green), for: .normal)
        editButton.layer.cornerRadius = 8
        editButton.backgroundColor = Color.background
        editButton.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        scrollView.addSubview(editButton)
        
        editButton.setConstraint(
            topAnchor: imageProfile.bottomAnchor, topAnchorConstant: 16,
            centerXAnchor: view.centerXAnchor,
            heighAnchorConstant: 35, widthAnchorConstant: 106)
    }
    
    @objc private func handleButton() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true)
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(Value1Cell.self, forCellReuseIdentifier: Value1Cell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.backgroundColor = Color.background
        scrollView.addSubview(tableView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        var totalRow = 0
        for section in 0..<tableView.numberOfSections {
            totalRow += tableView.numberOfRows(inSection: section)
        }
        let totalHeight = 40 * tableView.numberOfSections + totalRow * 44
                
        tableView.setConstraint(
            topAnchor: editButton.bottomAnchor, topAnchorConstant: 0,
            bottomAnchor: scrollView.bottomAnchor, bottomAnchorConstant: 0,
            leadingAnchor: safeArea.leadingAnchor, leadingAnchorConstant: 0,
            trailingAnchor: safeArea.trailingAnchor, trailingAnchorConstant: 0,
            heighAnchorConstant: CGFloat(totalHeight))
    }
    
}

extension ProfileEditViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageProfile.image = image
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}
