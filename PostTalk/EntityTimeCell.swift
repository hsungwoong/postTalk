//
//  EntityTimeCell.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 20..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import Foundation

//lat=37.5494730&long=126.9393889&dateType=M&fromdate=2015-07-20&todate=2015-08-20

struct EntityTimeCell {
    var dateType:String?;
    var list : [Any]?;
    
    var fromdate:String = "";
    var todate:String = "";
    
    var selFromdate:String = "";
    var selTodate:String = "";
    
    var nowYear:Int = NSDate().year();
    var nowMonth:Int = NSDate().month();
    var nowDay:Int = NSDate().day();
    
    var cidx:Int{
        get{
            var cnt:Int?;
            if let ll = list{
                
                for  var i = 0 ; i < ll.count ; ++i  {
                    
                }
            }
            
            return list!.count / 2;
        }
    }
    
    var prevDate:String {
        get{
            
            if let d = NSDate().convertStringToDate(selFromdate){
                if dateType == "M"{
                    return d.OffsetByMonth(-1)
                }else if dateType == "D"{
                    return d.OffsetByDay(-15)
                }
                return d.OffsetByYear(-1)
            }
            return selFromdate;
        }
    }
    
    var nextDate:String{
        get{
            if let d = NSDate().convertStringToDate(selTodate){
                
                if dateType == "M"{
                    return d.OffsetByMonth(1)
                }else if dateType == "D"{
                    return d.OffsetByDay(15)
                }
                return d.OffsetByYear(1)
            }
            return todate;
        }
    }
}
