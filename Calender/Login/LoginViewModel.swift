//
//  LoginViewModel.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation
import Firebase
import GoogleSignIn
import GoogleAPIClientForREST_Calendar

class LoginViewModel {

    // MARK: - Public Methods

    /// Initiates Google Sign-In process and authenticates the user with Firebase.
    /// - Parameters:
    ///   - presentingViewController: The view controller from which the sign-in flow is presented.
    ///   - completion: A closure that gets called with an error if the sign-in or authentication process fails, or nil if successful.
    func googleSignInAction(presentingViewController: UIViewController, completion: @escaping (Error?) -> Void) {
        // Ensure that the Firebase client ID is available.
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            // Return an error if the client ID is missing.
            completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Missing client ID"]))
            return
        }
        
        // Create Google Sign-In configuration object with the client ID.
        let config = GIDConfiguration(clientID: clientID)
        let scopes = [kGTLRAuthScopeCalendar]
        
        // Set the configuration for the Google Sign-In instance.
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign-in process.
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { authentication, error in
            // Check for an error during the sign-in process.
            if let error = error {
                completion(error)
                return
            }
            
            // Ensure that the user and ID token are available.
            guard let user = authentication?.user,
                  let idToken = user.idToken?.tokenString else {
                // Return an error if user data is missing.
                completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to retrieve user data"]))
                return
            }
            
            // Create a credential for Firebase authentication using the ID token and access token.
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            // Request additional scopes from the user.
            user.addScopes(scopes, presenting: presentingViewController)
            
            // Sign in to Firebase with the Google credential.
            Auth.auth().signIn(with: credential) { _, error in
                // Call the completion handler with the error if any, or nil if successful.
                completion(error)
            }
        }
    }
}
