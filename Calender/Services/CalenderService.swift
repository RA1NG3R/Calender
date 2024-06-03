//
//  CalenderService.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation
import GoogleAPIClientForREST_Calendar
import GoogleSignIn

class CalendarService {
    
    private let calendarService = GTLRCalendarService()
    
    init() {
        // Set the authorizer for the calendar service using the current signed-in user's credentials
        calendarService.authorizer = GIDSignIn.sharedInstance.currentUser?.fetcherAuthorizer
    }
    
    /// Lists events for a specific date.
    /// - Parameters:
    ///   - date: The date for which to fetch events.
    ///   - completion: A closure that is called with the result, which is either an array of events or an error.
    func listEvents(forDate date: Date, completion: @escaping (Result<[GTLRCalendar_Event], Error>) -> Void) {
        // Get the start of the specified date
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        
        // Calculate the end of the specified date (24 hours after the start of the day)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Convert start and end dates to GTLRDateTime
        let startDateTime = GTLRDateTime(date: startOfDay)
        let endDateTime = GTLRDateTime(date: endOfDay)
        
        // Create a query to list events between the start and end times
        let eventsListQuery = GTLRCalendarQuery_EventsList.query(withCalendarId: "primary")
        eventsListQuery.timeMin = startDateTime
        eventsListQuery.timeMax = endDateTime
        
        // Execute the query
        calendarService.executeQuery(eventsListQuery) { (ticket, result, error) in
            if let error = error {
                // Call the completion handler with the error if the query fails
                completion(.failure(error))
            } else {
                // Parse the result to get the list of events and call the completion handler with the events
                let events = (result as? GTLRCalendar_Events)?.items ?? []
                completion(.success(events))
            }
        }
    }
    
    /// Adds an event to Google Calendar.
    /// - Parameters:
    ///   - summary: The summary (title) of the event.
    ///   - description: The description of the event.
    ///   - startDate: The start date and time of the event.
    ///   - endDate: The end date and time of the event.
    ///   - completion: A closure that is called with an error if the addition fails, or nil if it succeeds.
    func addEventToGoogleCalendar(summary: String, description: String, startDate: Date, endDate: Date, completion: @escaping (Error?) -> Void) {
        // Create a new event object
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
        
        // Create a query to insert the event
        let insertQuery = GTLRCalendarQuery_EventsInsert.query(withObject: calendarEvent, calendarId: "primary")
        
        // Execute the query
        calendarService.executeQuery(insertQuery) { (ticket, object, error) in
            // Call the completion handler with the error if the query fails, or nil if it succeeds
            completion(error)
        }
    }
}
