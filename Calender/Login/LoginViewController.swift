//
//  ViewController.swift
//  Calender
//
//  Created by Subodh Mahajan on 31/05/24.
//

import UIKit
import GoogleSignIn
import Firebase
import GoogleAPIClientForREST_Calendar

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var btnSignIn: GIDSignInButton!  // Google Sign-In button
    
    // MARK: - Properties
    var viewModel = LoginViewModel()  // Instance of the view model
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func signInBtnAction(_ sender: Any) {
        // Call the sign-in action from the view model
        viewModel.googleSignInAction(presentingViewController: self) { [weak self] error in
            if let error = error {
                print("There is an error signing the user in ==> \(error)")
            } else {
                // Navigate to the Calendar view controller if sign-in is successful
                self?.navigateToCalendar()
            }
        }
    }
    
    // MARK: - Navigation
    @objc func navigateToCalendar() {
        // Instantiate the Calendar view controller from the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        
        // Push the Calendar view controller onto the navigation stack
        self.navigationController!.pushViewController(secondVC, animated: true)
    }
}


