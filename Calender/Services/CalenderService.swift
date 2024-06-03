//
//  CalenderService.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation

import Foundation
import GoogleAPIClientForREST_Calendar
import GoogleSignIn

class CalendarService {
    
    private let calendarService = GTLRCalendarService()
    
    init() {
        calendarService.authorizer = GIDSignIn.sharedInstance.currentUser?.fetcherAuthorizer
    }
    
    func listEvents(for date: Date, completion: @escaping (Result<[GTLRCalendar_Event], Error>) -> Void) {
        // Get the start and end of the specified day
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Convert to GTLRDateTime
        let startDateTime = GTLRDateTime(date: startOfDay)
        let endDateTime = GTLRDateTime(date: endOfDay)
        
        // Create the query
        let eventsListQuery = GTLRCalendarQuery_EventsList.query(withCalendarId: "primary")
        eventsListQuery.timeMin = startDateTime
        eventsListQuery.timeMax = endDateTime
        
        // Execute the query
        calendarService.executeQuery(eventsListQuery) { (ticket, result, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                let events = (result as? GTLRCalendar_Events)?.items ?? []
                completion(.success(events))
            }
        }
    }
    
    func addEventToGoogleCalendar(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Error?) -> Void) {
            let calendarEvent = GTLRCalendar_Event()
            calendarEvent.summary = summary
            calendarEvent.descriptionProperty = description
        
        // Create GTLRCalendar_EventDateTime objects with the start and end dates
            let startEventDateTime = GTLRCalendar_EventDateTime()
            startEventDateTime.dateTime = GTLRDateTime(date: startDate)
            
            let endEventDateTime = GTLRCalendar_EventDateTime()
            endEventDateTime.dateTime = GTLRDateTime(date: endDate)
            
            // Set the start and end times on the event
            calendarEvent.start = startEventDateTime
            calendarEvent.end = endEventDateTime
            
            let insertQuery = GTLRCalendarQuery_EventsInsert.query(withObject: calendarEvent, calendarId: "primary")
            
            calendarService.executeQuery(insertQuery) { (ticket, object, error) in
                completion(error)
            }
        }
}
