//
//  Utils.swift
//  Calender
//
//  Created by Subodh Mahajan on 02/06/24.
//

import Foundation
import GoogleAPIClientForREST_Calendar
import UIKit

class Utils {
    
    // MARK: - Alert Helper
    
    /// Shows an alert with the given title and message.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message to be displayed in the alert.
    ///   - vc: The view controller on which the alert should be presented.
    static func showAlert(title : String, message: String, vc: UIViewController) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default,
            handler: nil
        )
        alert.addAction(ok)
        vc.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Date Formatting Helpers
    
    /// Builds a GTLRCalendar_EventDateTime object from a Date object.
    ///
    /// - Parameter date: The date to be converted.
    /// - Returns: A GTLRCalendar_EventDateTime object representing the date.
    static func buildDate(date: Date) -> GTLRCalendar_EventDateTime {
        let datetime = GTLRDateTime(date: date)
        let dateObject = GTLRCalendar_EventDateTime()
        dateObject.dateTime = datetime
        return dateObject
    }
    
    /// Formats a GTLRDateTime object into a string with the specified formatter.
    ///
    /// - Parameters:
    ///   - dateTime: The GTLRDateTime object to be formatted.
    ///   - formatter: The date formatter string to be used (default is "dd MMM HH:mm").
    /// - Returns: A formatted string representing the date and time.
    static func formatDateTime(_ dateTime: GTLRDateTime?, formatter: String = "dd MMM HH:mm") -> String? {
        guard let date = dateTime?.date else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        
        return dateFormatter.string(from: date)
    }
}
