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
    
    // Helper to build date
   static func buildDate(date: Date) -> GTLRCalendar_EventDateTime {
        let datetime = GTLRDateTime(date: date)
        let dateObject = GTLRCalendar_EventDateTime()
        dateObject.dateTime = datetime
        return dateObject
    }
    
}
