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
    
    private let calendarService = GTLRCalendarService()
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var calender: FSCalendar!
    
    var viewModel = CalenderViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        resigterXIB()
        setupUI()
    }
    
    func setupUI() {
        calender.scrollDirection = .vertical
        self.navigationItem.setHidesBackButton(true, animated: false)
        var plusImage = UIImage(named: "plus")
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushEventVC))
        self.navigationItem.rightBarButtonItem = addButton
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.tblVw.reloadData()
            }
        }
    }
    
    func resigterXIB() {
        tblVw.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
    }
    
    @objc func pushEventVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "AddEventViewController") as! AddEventViewController
        present(secondVC, animated: true, completion: nil)
    }

}

extension CalenderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as! EventTableViewCell
        cell.lblEvent.text = viewModel.events[indexPath.row].summary
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 40
        }
}
