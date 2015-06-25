//
//  PostInsertVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

private var accView = PostInsertAccessory(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 49));

class PostInsertVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextViewDelegate, IPostInsertAccessoryDelegate {
    
    @IBOutlet var bottomToolbar: UIToolbar!
    @IBOutlet var myMemo: UITextView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!

    //@IBOutlet var myImageView: UIImageView!
    //@IBOutlet var keyboardHeight:NSLayoutConstraint!;
    
    let placeHolderText = "메세지를 입력해 주세요.";
    
    override var inputAccessoryView: UIView! {
        get {
            
            /*var toolBar = UIView(frame: CGRectMake(0, 0, 200, 49))
            var child = UIView(frame: CGRectMake(0, 0, 200, 49))
            child.backgroundColor = UIColor.lightGrayColor()
            toolBar.addSubview(child);
            toolBar.layer.zPosition = 0;
*/
            /*
           var container = UIView(frame: CGRectMake(0,0 , UIScreen.mainScreen().bounds.width, 49));
            
            var toolbar = UIToolbar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 49));
            
            var but = UIBarButtonItem(title: "좌측", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
            var but1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
            
            var but2 = UIBarButtonItem(title: "우측", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
            
            toolbar.items = [but,but1, but2];
            
            println("#### outside toolbar ");
            println(toolbar)
            container.addSubview(toolbar);
            
            return container;
*/
            //var acc = PostInsertAccessory(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 49));
            accView.delegate = self;
            return accView;
            //return  PostInsertAccessory(frame: CGRectZero)
        }
    }


    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("PostInsertVC", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //로그인페이지 호출
        //openLoginChk()

        self.myMemo.delegate = self;

        
        if (myMemo.text == "") {
            displayPlaceHolder(myMemo)
        }

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillChangeFrameNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true;
    }
    
    override func viewWillAppear(animated: Bool) {
        //
        self.becomeFirstResponder();
    }
    
    override func viewWillDisappear(animated: Bool) {
        //self.resignFirstResponder();
    }
    
    /**

        키보드 이벤트 헨들러
*/
    func keyboardWillShow(notification:NSNotification ) {
        
        println("### keyboardWillShow")
        /**/
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.CGRectValue().size
        
        var h = kbSize.height - 49;
        

        if h <= 0 { // 낮은 위치
            
            if accView.isIncludeImg(){
                accView.showImgBar();
                h = h + 80;
            }
            
        }else{ // 높은 위치
            if accView.isIncludeImg(){
                accView.hideImgBar();
            }
        }
        
        var contentInsets = UIEdgeInsetsMake(0, 0, h , 0)
        
        myMemo.contentInset = contentInsets
        myMemo.scrollIndicatorInsets = contentInsets;
        
        /*
        // optionally scroll
        var aRect = myMemo.superview!.frame
        
        aRect.size.height = aRect.size.height - CGFloat(kbSize.height + 45.0);
        let targetRect = CGRectMake(0, 0, 10, 10) // get a relevant rect in the text view
        if !aRect.contains(targetRect.origin) {
            myMemo.scrollRectToVisible(targetRect, animated: true)
        }
*/
    }
    
    
    
    func keyboardWillHide(notification:NSNotification ) {
        println("### keyboardWillHide")
        //println("include image: \(accView.isIncludeImg())")
        
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.CGRectValue().size
        
        var h = kbSize.height - 49;
        
        
        if h <= 0 { // 낮은 위치
            
            if accView.isIncludeImg(){
                accView.hideImgBar();
                
            }
            
        }else{ // 높은 위치
            if accView.isIncludeImg(){
                accView.showImgBar();
                h = h + 80;
            }
        }
        
        var contentInsets = UIEdgeInsetsMake(0, 0, h , 0)
        
        myMemo.contentInset = contentInsets
        myMemo.scrollIndicatorInsets = contentInsets;
        
        //UIEdgeInsetsZero

    }
    
/**

    텍스트뷰 위임자

*/
   
    func textViewDidBeginEditing(textView: UITextView) {
        if (textView.text == placeHolderText ){
            textView.text = ""
            textView.textColor = UIColor.blackColor()
        }
    }
    
    func displayPlaceHolder(textView: UITextView){
        if (textView.text == "") {
            textView.text = placeHolderText;
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        displayPlaceHolder(textView);

    }
    

    
    func sendPost(target: AnyObject) {
        //
        println("sendPost")

        myImageUploadRequest()
    }
    
    func selectAlbum(target: AnyObject) {
        //
        println("selectAlbum")
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

        self.presentViewController(myPickerController, animated: true, completion: nil)
    }
    
    func openCamera(target: AnyObject) {
        //
        println("openCamera")
    }
    

    //image album에서 선택
    @IBAction func selectPhotoButtonTapped(sender: AnyObject) {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(myPickerController, animated: true, completion: nil)

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

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {

        if let img: AnyObject = info[UIImagePickerControllerOriginalImage] {
            accView.addImage(img as! UIImage)
        }
       
        self.dismissViewControllerAnimated(true, completion: {
            //self.becomeFirstResponder();
            //accView.unvisibleKB();
            
        })
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string:APIUrl.postInsert);
        
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
        
        var imageData = NSData();
        
        //println("accView.getImage()\(accView.getImage())")
        
        if let img = accView.getImage() {
           imageData  = UIImageJPEGRepresentation(img , 0.1)
        }

        //if(imageData == nil) { return }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey:"file",imageDataKey:imageData, boundary:boundary)
        
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
                self.myActivityIndicator.stopAnimating();
                accView.emptyImage();
                self.myMemo.text = nil
                self.view.endEditing(true)// 키보드 내림
                //self.tabBarController?.selectedIndex = 0;//tabBar 위치변환
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
    
    
    @IBAction func hide(sender: AnyObject) {
        
        //
        self.myMemo.resignFirstResponder();
        self.resignFirstResponder();
        
        //약간 지연두고 등록창 닫기
        let delayTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(0.2 * Double(NSEC_PER_SEC)))
        
        dispatch_after(delayTime , dispatch_get_main_queue(), {
            self.dismissViewControllerAnimated(true, completion: nil);
        });
        
        //
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        //self.inputAccessoryViewController
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillShow:", object: nil );
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "keyboardWillHide:", object: nil )
    }
    
}




extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
        
    }
}
