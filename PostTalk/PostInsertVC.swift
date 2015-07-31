//
//  PostInsertVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

private var accView = PostInsertAccessory(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 49));

class PostInsertVC: BaseVC, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextViewDelegate, IPostInsertAccessoryDelegate , IDataPostInsert{
    
    @IBOutlet var bottomToolbar: UIToolbar!
    @IBOutlet var myMemo: UITextView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView!

    //@IBOutlet var myImageView: UIImageView!
    //@IBOutlet var keyboardHeight:NSLayoutConstraint!;
    
    let placeHolderText = "메세지를 입력해 주세요.";
    
    var isOpen = false;
    
    var postDataInsert:DataPostInsert!;
    
    var gps:GpsManager?;
    
    override var inputAccessoryView: UIView! {
        get {
            

            accView.delegate = self;
            return accView;
 
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
        
        self.postDataInsert = DataPostInsert();
        self.postDataInsert.delegate = self;

        
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
        isOpen = true;
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
            println("### keyboardWillShow 낮은 위치")
            if accView.isIncludeImg(){
                accView.showImgBar();
                h = h + 80;
            }
            
        }else{ // 높은 위치
            println("### keyboardWillShow 높은 위치")
            accView.hideImgBar();
            /*
            if accView.isIncludeImg(){
                accView.hideImgBar();
            }
*/
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
                
                if isOpen {
                    accView.showImgBar();
                    h = h + 80;
                }else{
                    accView.hideImgBar();
                }
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
        println("sendPost");
        

        
        var imgs:[UIImage]? = [UIImage]();
        if let img = accView.getImage(){
            imgs?.append(img);
        }
        
        println(imgs)
        
        
        
        var entity = EntityPostInfo();
        entity.memo = myMemo.text;
        entity.userId = "user5";
        
        if let g = gps{
            if let cl = g.currentLocation{
                //entity.mapLng = "\(cl.coordinate.longitude)";//String(format: "%f", cl.coordinate.longitude);
                //entity.mapLat =  "\(cl.coordinate.latitude)";//String(format: "%f", cl.coordinate.latitude);
                entity.mapLng = String(format: "%.7f", cl.coordinate.longitude);
                entity.mapLat =  String(format: "%.7f", cl.coordinate.latitude);
            }
        }
        
        println("entity \(entity.mapLng)");
        println("entity \(entity.mapLat)");
        println("entity \(entity.memo)");
        println("entity \(entity.userId)");
 //return;

        postDataInsert.send(entity, images: imgs);
    }
    
    func onPostInsertStart() {
        var alert = UIAlertController(title: "데이타 전송중...", message: "잠시만 기다려주세요.", preferredStyle: UIAlertControllerStyle.Alert);
        
        //self.presentViewController(alert, animated: true, completion: nil);
    }
    
    func onPostInsertComplete() {
        //
        //self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func onPostInsertFail() {
        //self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
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
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {

        if let img: AnyObject = info[UIImagePickerControllerOriginalImage] {
            accView.addImage(img as! UIImage)
        }
       
        self.dismissViewControllerAnimated(true, completion: {
            //self.becomeFirstResponder();
            //accView.unvisibleKB();
            
        })
    }

    
    @IBAction func hide(sender: AnyObject) {
        isOpen = false;
        
        //이미지 비우기
        accView.emptyImage();
        
        //메모 공백
        myMemo?.text = "";
        
        //퍼스트에서 해제
        if self.myMemo.isFirstResponder() {
            self.myMemo.resignFirstResponder();
        }
        
        if self.isFirstResponder(){
            
            self.resignFirstResponder();
        }
        
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

