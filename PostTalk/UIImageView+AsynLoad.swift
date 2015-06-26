//
//  UIImageView+AsynLoad.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 25..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                
                println("image load error : \(error)")
                if error == nil{
                    //println("complete sendAsynchronousRequest : \(data)")
                    self.image = UIImage(data: data);
                }else{
                    self.image = nil;
                }
            }
        }// end if
    }//end func
}