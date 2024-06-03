//
//  AddEventViewModel.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation
import GoogleAPIClientForREST_Calendar

class EventViewModel {
    
    private let calendarService = CalendarService()
    
    var event: GTLRCalendar_Event?
    var onError: ((Error) -> Void)?
    
    func addEvent(summary: String, description: String, startDate: Date, endDate: Date) {
        calendarService.addEventToGoogleCalendar(summary: summary, description: description, startDate: startDate, endDate: endDate) { [weak self] error in
                if let error = error {
                    self?.onError?(error)
                    print(error)
                }
            }
        }
    
    
}
