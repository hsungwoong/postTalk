//
//  ITimeCellDelegate.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 20..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import Foundation


protocol ITimeCellDelegate {
    // protocol definition goes here
    func timeCell(timeCell: TimeCell, index:Int)->EntityTimeCell;
    func timeCell(timeCell: TimeCell, index:Int, selFromdate:String, selTodate:String);
    func timeCell(timeCell: TimeCell , didSelectItem:Ballon , selFromdate:String, selTodate:String, dateType:String);
    
}