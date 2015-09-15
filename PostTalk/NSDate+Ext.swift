//
//  NSDate+Ext.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 20..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit
import Foundation

extension NSDate {
    
    func firstDateOfTheMonth() -> NSDate{
        //https://gist.github.com/benjamintanweihao/63c302852c0444189be1
        
        var unitFlags = NSCalendarUnit.CalendarUnitYear |
            NSCalendarUnit.CalendarUnitMonth
        
        let calendar = NSCalendar.currentCalendar()
        let components = NSCalendar.currentCalendar().components( unitFlags, fromDate: self)
        
        
        // Getting the First and Last date of the month
        components.day = 1
        let firstDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
        return firstDateOfMonth;
    }
    
    func lastDateOfTheMonth() -> NSDate{
        //https://gist.github.com/benjamintanweihao/63c302852c0444189be1
        
        var unitFlags = NSCalendarUnit.CalendarUnitYear |
            NSCalendarUnit.CalendarUnitMonth
        
        let calendar = NSCalendar.currentCalendar()
        let components = NSCalendar.currentCalendar().components(unitFlags, fromDate: self)
        
        
        // Getting the First and Last date of the month
        components.day = 1
        let firstDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
        components.month  += 1
        components.day     = 0
        let lastDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
        
        return lastDateOfMonth;
    }
    
    func OffsetByYear(yy:Int) -> String {
        let calendar = NSCalendar.currentCalendar();
        let components = NSDateComponents();
        components.year = yy;
        
        
        if let ago = calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(0)){
            return ago.toShortDateString();
        }

        return "";
        
    }
    
    func OffsetByMonth(mm:Int) -> String {
        let calendar = NSCalendar.currentCalendar();
        let components = NSDateComponents();
        components.year = 0;
        components.month = mm;
        
        
        if let ago = calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(0)){
            return ago.toShortDateString();
        }
        
        return "";
        
    }
    
    func OffsetByDay(dd:Int) -> String {
        let calendar = NSCalendar.currentCalendar();
        let components = NSDateComponents();
        components.year = 0;
        components.month = 0;
        components.day = dd;
        
        
        if let ago = calendar.dateByAddingComponents(components, toDate: self, options: NSCalendarOptions(0)){
            return ago.toShortDateString();
        }
        
        return "";
        
    }
    
    func year() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components( NSCalendarUnit.CalendarUnitYear, fromDate: self)
        let year = components.year;
        
        //Return Hour
        return year;
    }
    
    func month() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components( NSCalendarUnit.CalendarUnitMonth, fromDate: self)
        let month = components.month
        
        //Return Hour
        return month
    }
    
    func day() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components( NSCalendarUnit.CalendarUnitDay, fromDate: self)
        let day = components.day
        
        //Return Hour
        return day
    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitMinute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func convertStringToDate(ss:String)-> NSDate?{
        //println("ss  \(ss)")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd";
        return dateFormatter.dateFromString(ss);
    }
    
    func toShortDateString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        //formatter.timeStyle = .ShortStyle
        formatter.dateFormat = "yyyy-MM-dd";
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
}
