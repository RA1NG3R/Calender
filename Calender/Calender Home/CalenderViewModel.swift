//
//  CalenderViewModel.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation
import Firebase
import GoogleSignIn
import GoogleAPIClientForREST_Calendar

class CalenderViewModel {
    
    private let calendarService = CalendarService()
    
    var events: [GTLRCalendar_Event] = []
    var onEventsUpdated: (() -> Void)?
    var reloadData: (() -> Void)?
    
    init() {
        fetchEvents()
    }
    func fetchEvents(forDate date: Date = Date()) {
        // Fetch events for the day
        calendarService.listEvents(forDate: date) { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events
                self?.reloadData?()
                self?.onEventsUpdated?()
            case .failure(let error):
               print(error)
            }
        }
    }
    
    /// Signs out the current user from Firebase and Google Sign-In.
    /// - Parameter completion: A closure that gets called with an error if the sign-out process fails, or nil if successful.
    func signOut(completion: @escaping (Error?) -> Void) {
        // Sign out from Firebase.
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            completion(signOutError)
            return
        }

        // Sign out from Google.
        GIDSignIn.sharedInstance.signOut()
        
        // Call the completion handler with nil, indicating the sign-out was successful.
        completion(nil)
    }
}
