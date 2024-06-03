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
    
    
    @IBOutlet weak var btnSignIn: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @objc func presentSecondVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: "CalenderViewController") as! CalenderViewController
        self.navigationController!.pushViewController(secondVC, animated: true)
    }
    
    
    @IBAction func signInBtnAction(_ sender: Any) {
        
        googleSignInAction()
        
    }
    
    func googleSignInAction() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        let scopes = [kGTLRAuthScopeCalendar]
        
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { authentication, error in
            if let error = error {
                print("There is an error signing the user in ==> \(error)")
                return
            }
            self.presentSecondVC()
            guard let user = authentication?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            user.addScopes(scopes, presenting: self)
            // Sign in with Firebase
            Auth.auth().signIn(with: credential) { authResult, error in
                if error != nil {
                    print(error!)
                }
            }
        }
    }
}

