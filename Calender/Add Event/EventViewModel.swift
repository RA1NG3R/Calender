//
//  AddEventViewModel.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation
import GoogleAPIClientForREST_Calendar

class EventViewModel {
    
    // MARK: - Properties
    
    private let calendarService: CalendarService
    
    // MARK: - Initialization
    
    init(calendarService: CalendarService = CalendarService()) {
        self.calendarService = calendarService
    }
    
    // MARK: - Methods
    
    func addEvent(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Error?) -> Void) {
        calendarService.addEventToGoogleCalendar(summary: summary, description: description, startDate: startDate, endDate: endDate) { error in
            completion(error)
            if let error = error {
                print(error)
            }
        }
    }
}

