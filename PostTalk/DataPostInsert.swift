//
//  DataPostInsert.swift
//  PostTalk
//
//  Created by dykim on 2015. 7. 9..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class DataPostInsert: NSObject {
    
    //var entity:EntityPostInfo?;
    //var images:[UIImage]?;
    /*
    init(et:EntityPostInfo){
        entity = et;
        super.init();
    }
    */
    
    var delegate:IDataPostInsert?;
    
    func send(entity:EntityPostInfo?, images:[UIImage]?){
        

        
    
        let url = NSURL(string:APIUrl.postInsert);
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST";
        
        // set Content-Type in HTTP header
        let boundaryConstant = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy";
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        NSURLProtocol.setProperty(contentType, forKey: "Content-Type", inRequest: request)
        

        
        var param = [String:String]();
        
        if let et = entity {
            
            param["USER_ID"] = et.userId!;
            param["MEMO"] = et.memo!;
            param["MAP_LNG"] = et.mapLng!;
            param["MAP_LAT"] = et.mapLat!;

        }
        
        
        var imageData:NSData?;
        var image_group_code:String = "";
        let boundary = generateBoundaryString();
        
        if let imgs = images{
            
            if imgs.count > 0 {
                

                
                imageData  = UIImageJPEGRepresentation(imgs[0] , 0.1);
                
                image_group_code = "G"+makeImageName();
                param["IMAGE_GROUP_CODE"] = image_group_code;
                
                
                
            }

        }
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField:"Content-Type")
        request.HTTPBody = createBodyWithParameters(param, filePathKey:"file",imageDataKey:imageData, boundary:boundary)
        
        //서버에 보내기 시작
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data,response,error in
            
            if error != nil{
                println("error =\(error)")
                self.delegate?.onPostInsertFail();
                return;
                
            }
            
            //You can print out response object
            println("******* response = \(response)")
            
            //Print out response body
            let responseString = NSString(data:data, encoding:NSUTF8StringEncoding)
            println("******* response data = \(responseString!)")
            
            dispatch_async(dispatch_get_main_queue(), {
                self.delegate?.onPostInsertComplete();
                
                
                /*
                self.myActivityIndicator.stopAnimating();
                accView.emptyImage();
                self.myMemo.text = nil
                self.view.endEditing(true)// 키보드 내림
                //self.tabBarController?.selectedIndex = 0;//tabBar 위치변환
                
                alert.hide
*/
            });
            
        }
        
        self.delegate?.onPostInsertStart();
        task.resume();
    }

    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData?, boundary: String) -> NSData {
        let body = NSMutableData();
        
        //포스트 정보
        if parameters != nil {
            for (key, value) in parameters! {
                if !value.isEmpty {
                    body.appendString("--\(boundary)\r\n")
                    
                    //body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
                    //body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                    //body.appendData(imageDataKey)
                    
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString("\(value)\r\n")
                    
                    println("!!!key-> \(key)");
                    println("!!!value-> \(value)")
                }
            }
        }
        
        
        // 이미지 데이타
        if let imgdata = imageDataKey{
            
            let filename = makeImageName()+".png" //"user-profile.jpg"
            
            //let mimetype = "image/jpg"
            let mimetype = "application/octet-stream"
            
            
            // Image
            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format:"Content-Disposition: form-data; name=\"file1\"; filename=\(filename)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            body.appendData(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
            
            body.appendData(imgdata)
            
            
            body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
            
            
            
            body.appendString("–-\(boundary)–-\r\n")
            
        }
        
       
        
        return body;
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    //고유 이미지 생성키
    func makeImageName()->String {
        
        let now = NSDate() // 현재 날짜 및 시간 체크
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ko_KR") // 로케일 설정
        dateFormatter.dateFormat = "yyyyMMddHHmmss" // 날짜 형식 설정
        
        
        //println(dateFormatter.stringFromDate(now)+String(arc4random())
        return dateFormatter.stringFromDate(now)+String(arc4random())
    }

}

extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
        
    }
}
