//
//  AddEventViewController.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

enum Event: String {
    case add
    case view
}

class EventViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    var viewModel = EventViewModel()
    var type: Event = .add
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        switch type {
        case .add:
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
                   navigationItem.rightBarButtonItem = addButton
            self.navigationController?.title = "Add Event"
            self.startDatePicker.isEnabled = true
            self.endDatePicker.isEnabled = true
            endDatePicker.datePickerMode = .dateAndTime
            let currentDate = Date()
            startDatePicker.date = currentDate
            endDatePicker.date = currentDate.addingTimeInterval(60*60)
        case .view:
            self.titleTextField.text = viewModel.event?.summary
            self.descriptionTextField.text = viewModel.event?.descriptionProperty
            self.startDatePicker.isEnabled = false
            self.endDatePicker.isEnabled = false
            if let startDate = viewModel.event?.start?.dateTime?.date {
                self.startDatePicker.date = startDate
            }
            if let endDate = viewModel.event?.end?.dateTime?.date {
                self.endDatePicker.date = endDate
            }
            break
            
        }
    }
    
    @objc func addButtonTapped() {
        guard validateFields() else { return }
        
        viewModel.addEvent(summary: titleTextField.text ?? "", description: descriptionTextField.text ?? "", startDate: startDatePicker.date, endDate: endDatePicker.date)
        navigationController?.popViewController(animated: true)
       }
    
    
    @IBAction func addEventBtnAction(_ sender: Any) {
        
        
    }
    
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
