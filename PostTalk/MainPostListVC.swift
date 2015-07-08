//
//  MainPostListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit
import CoreLocation

class MainPostListVC: CommonPostListVC, IGpsManagerDelegate{
 
    @IBOutlet var cateToolbar: UIToolbar!
    @IBOutlet var cateBuletBarbtn: UIBarButtonItem!
    @IBOutlet var cateChildBarbtn: UIBarButtonItem!
    
    @IBOutlet var postInsertBar: UIView!

    @IBOutlet var postInsertBarBottomMargin: NSLayoutConstraint!
    var gps:GpsManager!;
    
    var initedGpsUpdate = false;
    
    //var insertBar:PostInsertBar!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        createPostInsertButton();
        creatNaviBarRightButtons();
         createInsertBar();
        setupSortMenu();
        
        setupGps();
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillChangeFrameNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    
    /**
    
    키보드 이벤트 헨들러
    */
    func keyboardWillShow(notification:NSNotification ) {
        
        println("### keyboardWillShow")
        /**/
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.CGRectValue().size;
        
        var h = kbSize.height - 49;
        
        let duration = info![UIKeyboardAnimationDurationUserInfoKey] as! Double;
        let curve = info![UIKeyboardAnimationCurveUserInfoKey] as! Int;
 println(            self.postInsertBar.constraints());
        
        self.postInsertBarBottomMargin.constant = h;
        
        UIView.animateWithDuration(duration, delay: 0.03, options: UIViewAnimationOptions(rawValue: UInt(curve << 16)), animations: {
                //var bb = self.postInsertBar.bounds;
                //bb.origin.y = h;
                //self.postInsertBar.bounds = bb;
            self.postInsertBar.layoutIfNeeded();
           
        //
            }, completion: {finished in
                //
        });
        
        //UITextInputStringTokenizer
        
        
        if h <= 0 { // 낮은 위치
            //println("### keyboardWillShow 낮은 위치")
            //if accView.isIncludeImg(){
             //   accView.showImgBar();
            //    h = h + 80;
            //}
            
        }else{ // 높은 위치
            //println("### keyboardWillShow 높은 위치")
            //accView.hideImgBar();
            /*
            if accView.isIncludeImg(){
            accView.hideImgBar();
            }
            */
        }
        
        var contentInsets = UIEdgeInsetsMake(0, 0, h , 0)
        
       // myMemo.contentInset = contentInsets
        //myMemo.scrollIndicatorInsets = contentInsets;
        
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

        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.CGRectValue().size
        
        var h = kbSize.height - 49;
        
        
        if h <= 0 { // 낮은 위치
            
            //
            
        }else{ // 높은 위치
            //
        }
        
        var contentInsets = UIEdgeInsetsMake(0, 0, h , 0)
        
        //myMemo.contentInset = contentInsets
        //myMemo.scrollIndicatorInsets = contentInsets;

    }
    
    
    
    override func getLoader() -> BaseDataAccessManager? {
        return DataMainPostLIst();
    }
    override func getUrl() -> String? {
        return APIUrl.mainList;
    }
    
    override func getParams() -> String? {
        var p = "long=\(gps.currentLocation!.coordinate.longitude)&";
        p += "lat=\(gps.currentLocation!.coordinate.latitude)&"
        return p;
    }
    
    func createInsertBar(){
        //self.insertBar = PostInsertBar(frame: CGRectMake(0, 200, view.frame.size.width, 44));
        //self.view.translatesAutoresizingMaskIntoConstraints();
        //self.view.addSubview(self.insertBar);
        
        //self.insertBar.center.y = 300;
        //self.view.bringSubviewToFront(self.insertBar);
        /*
        var leftMargin = NSLayoutConstraint(item: insertBar, attribute: NSLayoutAttribute.LeadingMargin, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: -6);
        self.view.addConstraint(leftMargin);
        
        var righMargin = NSLayoutConstraint(item: insertBar, attribute: NSLayoutAttribute.TrailingMargin, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: -6)
        self.view.addConstraint(righMargin);
       
        var bottonMargin = NSLayoutConstraint(item: insertBar, attribute: NSLayoutAttribute.BottomMargin, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 44);
        self.view.addConstraint(bottonMargin);
       */
        
    }
    
    func setupGps(){
        gps = GpsManager();
        gps.delegate = self;
        //gps.start();
    }
    
    /**
        gps manager delegate
    */
    func onGpsDidStart() {
        //
        println("####")
        println("onGpsDidStart")
        
        //self.requestData();
    }
    
    func onGpsAuthDeny() {
        println("####")
        println("onGpsAuthDeny")
    }
    
    func onGpsDidUpdateCurrentLocation() {

        println("#####")
        println("onGpsDidUpdateCurrentLocation")
        
        //앱실행시 현재 사용자 위치 업데이트 최초 한번 발생할때만 데이타 로드
        if !initedGpsUpdate {
            
            self.requestData();
            initedGpsUpdate = true;
        }
    }
    
    override func refresh(target: UIBarButtonItem) {
        super.refresh(target);
        self.requestData();
    }
    
    /**
        정렬메뉴 설정
    */
    func setupSortMenu() {
        cateToolbar.setBackgroundImage(UIImage(named: "cate_toolbar_bg.png"), forToolbarPosition: UIBarPosition.Bottom, barMetrics: UIBarMetrics.Default)
        
        cateBuletBarbtn.customView = UIImageView(image: UIImage(named: "bulet_cate.png"))
    }
    
    @IBAction func onTouchCate(sender: AnyObject) {
        //
    }
    
    @IBAction func onPan(sender:AnyObject){
        println(sender);
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
