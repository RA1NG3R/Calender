//
//  CalenderViewController.swift
//  Calender
//
//  Created by Subodh Mahajan on 01/06/24.
//

import UIKit
import FSCalendar
import GoogleAPIClientForREST_Calendar
import GoogleSignIn

class CalenderViewController: UIViewController {
    
    // MARK: - Properties
    
    private let calendarService = GTLRCalendarService()
    @IBOutlet weak var tblVw: UITableView! {
        didSet {
            tblVw.alpha = 0
        }
    }
    @IBOutlet weak var calender: FSCalendar!
    @IBOutlet weak var btnSignOut: UIButton!
    
    var viewModel = CalenderViewModel()
    var currentDataTime = Date()
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerXIB()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        // Configure FSCalendar
        calender.scrollDirection = .vertical
        
        // Hide back button
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Add right bar button items
        let reloadButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadButtonTapped))
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushEventVC))
        self.navigationItem.rightBarButtonItems = [addButton, reloadButton]
        
        // Set reload data closure
        viewModel.reloadData = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tblVw.reloadData()
                self.tblVw.alpha = 1
            }
        }
    }
    
    // MARK: - Table View Registration
    
    private func registerXIB() {
        tblVw.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
        tblVw.register(UINib(nibName: "NoEventsTableViewCell", bundle: nil), forCellReuseIdentifier: "NoEventsTableViewCell")
    }
    
    // MARK: - Sign Out
    
    func handleSuccessfulSignOut() {
        // Navigate to the login screen or perform other appropriate actions
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Button Actions
    
    @objc func pushEventVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let eventVC = storyboard.instantiateViewController(withIdentifier: "EventViewController") as? EventViewController {
            navigationController?.pushViewController(eventVC, animated: true)
        }
    }
    
    @objc func reloadButtonTapped() {
        viewModel.fetchEvents()
        calender.deselect(currentDataTime)
        //calender.reloadData()
    }
    
    @IBAction func signOutBtnAction(_ sender: Any) {
        viewModel.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                // Handle sign out error
                print("Sign out error: \(error.localizedDescription)")
                Utils.showAlert(title : "Error", message: error.localizedDescription, vc: self)
            } else {
                // Handle successful sign out
                print("Sign out successful")
                self.handleSuccessfulSignOut()
            }
        }
    }
}

// MARK: - FSCalendarDelegate

extension CalenderViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        currentDataTime = date
        viewModel.fetchEvents(forDate: date)
    }
}

// MARK: - UITableViewDataSource

extension CalenderViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.events.isEmpty ? 1 : viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.events.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoEventsTableViewCell", for: indexPath) as! NoEventsTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
            let event = viewModel.events[indexPath.row]
            cell.lblEvent.text = event.summary
            if let startDateTime = event.start?.dateTime {
                let formattedDateTime = Utils.formatDateTime(startDateTime)
                cell.lblDate.text = formattedDateTime
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushEventDeatailsVC(event: viewModel.events[indexPath.row])
    }
    
    func pushEventDeatailsVC(event: GTLRCalendar_Event) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let eventDetailVC = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController") as? EventDetailsViewController {
            eventDetailVC.viewModel.event = event
            navigationController?.pushViewController(eventDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel.events.isEmpty ? 300 : 72
    }
}
