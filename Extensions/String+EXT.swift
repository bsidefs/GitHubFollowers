//
//  String+EXT.swift
//  GithubFollowers
//
//  Created by Brian Tamsing on 10/10/20.
//  Copyright © 2020 Brian Tamsing. All rights reserved.
//

import Foundation

/* currently unused. keeping for archives */
extension String {
    
    /**
     * Converts a Date to an intermediary string format.
     */
    func convertToDate() -> Date? {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone      = .current
        
        return dateFormatter.date(from: self)
    }
    
    /**
     * Converts a date string to a proper display format.
     */
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "" }
        
        return date.convertToMonthYearFormat()
    }
}
