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
            
            var request = NSURLRequest(URL: url);
            
            var cachedResponse:NSCachedURLResponse? = NSURLCache.sharedURLCache().cachedResponseForRequest(request);
            println(cachedResponse)
            if let cr = cachedResponse {
                println("캐쉬된 이미지 있음");
                
                var downloadedImage = UIImage(data: cr.data);
                //UIImage *downloadedImage = [UIImage imageWithData:cachedResponse.data];
                
                //dispatch_async(<#queue: dispatch_queue_t#>, <#block: dispatch_block_t##() -> Void#>)
                dispatch_async(dispatch_get_main_queue(), {
                    self.image = downloadedImage;
                });

            }else{
                println("캐쉬된 이미지 없음")
                
                var config = NSURLSessionConfiguration.defaultSessionConfiguration()
                config.requestCachePolicy = NSURLRequestCachePolicy.ReturnCacheDataElseLoad
                config.URLCache = NSURLCache.sharedURLCache();
                var sesson = NSURLSession(configuration: config);
//                var session = NSURLSession(configuration: config, delegate: self, delegateQueue: nil)
                var dataTask = sesson.dataTaskWithRequest(request, completionHandler: {
                    (data:NSData!, resp: NSURLResponse!, error: NSError!) -> Void in
                    if (error == nil) {
                        var downloadedImage = UIImage(data: data);
                        dispatch_async(dispatch_get_main_queue(), {
                            self.image = downloadedImage;
                        });
                    }
                });
                
                dataTask.resume();
                
            }

            
            /*
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
*/

        }// end if
    }//end func
    
    public func test(){
        //NSURLSession
        //NSURLCache
    }
}