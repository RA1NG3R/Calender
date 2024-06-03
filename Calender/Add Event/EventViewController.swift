//
//  AddEventViewController.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

class EventViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    // MARK: - Properties
    
    var viewModel = EventViewModel()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Setup
    
    func setupUI() {
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        self.title = "Add Event" // Set navigation title
        startDatePicker.isEnabled = true
        endDatePicker.isEnabled = true
        endDatePicker.datePickerMode = .dateAndTime
        let currentDate = Date()
        startDatePicker.date = currentDate
        endDatePicker.date = currentDate.addingTimeInterval(60*60)
    }
    
    // MARK: - Button Actions
    
    @objc func addButtonTapped() {
        guard validateFields() else { return }
        
        viewModel.addEvent(summary: titleTextField.text ?? "", description: descriptionTextField.text ?? "", startDate: startDatePicker.date, endDate: endDatePicker.date) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                // Handle error
                Utils.showAlert(title: "Error", message: error.localizedDescription, vc: self)
            } else {
                // Successfully added event
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    // MARK: - Field Validation
    
    func validateFields() -> Bool {
        if titleTextField.text?.isEmpty == true && descriptionTextField.text?.isEmpty == true {
            Utils.showAlert(title: "Error", message: "Title and Description cannot be both empty.", vc: self)
            return false
        }
        
        if endDatePicker.date < startDatePicker.date {
            Utils.showAlert(title: "Error", message: "End date cannot be earlier than start date.", vc: self)
            return false
        }
        return true
    }
    
}
