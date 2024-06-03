//
//  EventDetailsViewController.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

class EventDetailsViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var lblEnd: UILabel!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var lblDescription: UILabel!
    
    var viewModel = EventDetailsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
       
    }
    
    func setupUI() {
        self.navigationController?.title = "Event Details"
        lblTitle.text = viewModel.event?.summary
        lblDescription.text = viewModel.event?.descriptionProperty
        startDate.isEnabled = false
        endDate.isEnabled = false
        if let startDate = viewModel.event?.start?.dateTime?.date {
            self.startDate.date = startDate
        }
        if let endDate = viewModel.event?.end?.dateTime?.date {
            self.endDate.date = endDate
        }
    }

}
