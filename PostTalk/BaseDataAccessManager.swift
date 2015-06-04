//
//  BaseDataAccessManager.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 7..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class BaseDataAccessManager: NSObject {

    var delegate:IBaseDataAccessManager?;
    var entities:[Any]?;
    
    var total:Int{
        
        if let cnt = entities?.count {
            return cnt;
        }
        return 0;
    }
    
    /**
    데이타 요청
*/
    func load(url:String){
        /**/
        let httpMethod = "POST"
        let timeout = 15
        let url = NSURL(string: url)
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalAndRemoteCacheData, timeoutInterval:15.0)
        let queue = NSOperationQueue.mainQueue();
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: queue,completionHandler:complete)

    }
    
    /**
        데이타 로드 성공
    
    */
    func complete(response: NSURLResponse!,data: NSData!,error: NSError!){
        
        if data.length > 0 && error == nil{
            // we serialize our bytes back to the original JSON structure
            let jsonResult: NSDictionary? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
            
            parserJson(jsonResult);
            
            delegate?.onLoadedData();
            
        }else if data.length == 0 && error == nil{
            println("Nothing was downloaded")
        } else if error != nil{
           
            fail();
        }
    }
    
    /**
    
    json 해석.
    각 하위 클래스별로 다르게 override

*/
    func parserJson(jsonResult:NSDictionary?){
        //println(jsonResult);
    }
    
    /**
        데이타 로드 실패

*/
    func fail(){
         //println("Error happened = \(error)")
    }
    
    
   
}
