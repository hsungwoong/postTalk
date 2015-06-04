//
//  PostInsertVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostInsertVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var myMemo: UITextField!
    @IBOutlet var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //로그인페이지 호출
        openLoginChk()
        
    }
    
    //image album에서 선택
    @IBAction func selectPhotoButtonTapped(sender: AnyObject) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    //포스트 등록
    @IBAction func PostInsertButton(sender: AnyObject) {
        myImageUploadRequest()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("PostInsertVC", owner: self, options: nil)
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
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    //UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string:"http://52.68.46.70/postInsert_ok.php")
        //let cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        //let request = NSMutableURLRequest(URL: myUrl!, cachePolicy: cachePolicy, timeoutInterval: 5.0)
        let request = NSMutableURLRequest(URL: myUrl!)
        
        request.HTTPMethod = "POST"
        
        // set Content-Type in HTTP header
        let boundaryConstant = "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy";
        let contentType = "multipart/form-data; boundary=" + boundaryConstant
        NSURLProtocol.setProperty(contentType, forKey: "Content-Type", inRequest: request)
        
        let image_group_code = "G"+makeImageName()
        
        let param = [
            "MEMO":self.myMemo.text!,
            "USER_ID":"user5",
            "IMAGE_GROUP_CODE":image_group_code]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)",
            forHTTPHeaderField:"Content-Type")
        
        let imageData = UIImageJPEGRepresentation(myImageView.image, 0.1)
        
        if(imageData == nil) { return }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey:"file",imageDataKey:imageData,boundary:boundary)
        
        myActivityIndicator.startAnimating()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            data,response,error in
            
            if error != nil{
                println("error =\(error)")
                return
                
            }
            
            //You can print out response object
            println("******* response = \(response)")
            
            //Print out response body
            let responseString = NSString(data:data, encoding:NSUTF8StringEncoding)
            println("******* response data = \(responseString!)")
            
            dispatch_async(dispatch_get_main_queue(), {
                self.myActivityIndicator.stopAnimating()
                self.myImageView.image = nil
                self.myMemo.text = nil
                self.view.endEditing(true)// 키보드 내림
                self.tabBarController?.selectedIndex = 0;//tabBar 위치변환
            });
            
        }
        
        task.resume()
        
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                
                //body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
                //body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                //body.appendData(imageDataKey)
                
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = makeImageName()+".png" //"user-profile.jpg"
        
        //let mimetype = "image/jpg"
        let mimetype = "application/octet-stream"
        
        
        // Image
        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"file1\"; filename=\(filename)\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(imageDataKey)
        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        /*
        body.appendString("–-\(boundary)\r\n")
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"file1\"; filename=\"img.jpg\" \r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        //body.appendString("Content-Disposition: form-data; name='file1'; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        */
        body.appendString("–-\(boundary)–-\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
}




extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
        
    }
}
