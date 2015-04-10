//
//  Date.swift
//  Taskit
//
//  Created by Sónia Rosa on 28/03/15.
//  Copyright (c) 2015 Sónia Rosa. All rights reserved.
//

import Foundation


class Date {
    
     // retorna uma data com ano, mes, dia
    class func from(#year: Int, month: Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)!
        
        var date = gregorianCalendar.dateFromComponents(components)
        return date!
    }
    
    class func dateToString(#date: NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        return dateString
        
    }
}
