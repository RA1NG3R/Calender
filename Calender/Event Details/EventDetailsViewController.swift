//
//  EventDetailsViewController.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import UIKit

class EventDetailsViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    // MARK: - Properties
    
    var viewModel = EventDetailsViewModel() // ViewModel responsible for managing event details
    var start = "" // String to hold formatted start time
    var end = "" // String to hold formatted end time
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    func setupUI() {
        // Set navigation title
        self.navigationItem.title = "Event Details"
        
        // Set event title
        lblTitle.text = viewModel.event?.summary
        
        // Format and set start time
        if let startDateTime = viewModel.event?.start?.dateTime {
            let formattedDateTime = Utils.formatDateTime(startDateTime)
            start = formattedDateTime ?? ""
        }
        
        // Format and set end time
        if let endDateTime = viewModel.event?.end?.dateTime {
            let formattedDateTime = Utils.formatDateTime(endDateTime)
            end = formattedDateTime ?? ""
        }
        
        // Set duration label
        lblDuration.text = "Starts at \(start) till \(end)"
        
        // Set event description
        lblDescription.text = viewModel.event?.descriptionProperty
    }
}
