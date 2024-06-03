//
//  CalenderViewModel.swift
//  Calender
//
//  Created by Subodh Mahajan on 03/06/24.
//

import Foundation
import GoogleAPIClientForREST_Calendar

class CalenderViewModel {
    
    private let calendarService = CalendarService()
    
    var events: [GTLRCalendar_Event] = []
    var onEventsUpdated: (() -> Void)?
    var onError: ((Error) -> Void)?
    var reloadData: (() -> Void)?
    
    init() {
        fetchEvents()
    }
    
    func fetchEvents(for date: Date = Date()) {
        calendarService.listEvents(for: date) { [weak self] result in
            switch result {
            case .success(let events):
                self?.events = events
                self?.reloadData?()
                self?.onEventsUpdated?()
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
