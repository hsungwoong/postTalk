//
//  MainPostListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit
import CoreLocation

class MainPostListVC: CommonPostListVC, IGpsManagerDelegate, UITextViewDelegate, IDataPostInsert{
 
    @IBOutlet var btnInsertShort: UIButton!
    @IBOutlet var btnInsertDetail: UIButton!
    @IBOutlet var inputBg: UIView!
    @IBOutlet var inputText: UITextView!
    @IBOutlet var cateToolbar: UIToolbar!
    @IBOutlet var cateBuletBarbtn: UIBarButtonItem!
    @IBOutlet var cateChildBarbtn: UIBarButtonItem!
    
    @IBOutlet var postInsertBar: UIView!

    @IBOutlet var postInsertBarBottomMargin: NSLayoutConstraint!
    @IBOutlet var selSort: UISegmentedControl!
    var gps:GpsManager!;
    
    var initedGpsUpdate = false;
    
    var postDataInsert:DataPostInsert! = DataPostInsert();
    
    var searchParam:EntitySearch = EntitySearch();
    
    var alert:UIAlertController?;
   
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        println("-------")
        println(NSDate().year());
        println(NSDate().month());
        println(NSDate().day());
        println(NSDate().toShortDateString())
        println(NSDate().OffsetByDay(-5));
        println(NSDate().OffsetByMonth(-5));
        println(NSDate().OffsetByYear(-5));
   println( NSDate().convertStringToDate("2014-10")   );
  println("------>>-")
        
       
        //createPostInsertButton();
        creatNaviBarRightButtons();
        createInsertBar();
        
        setupSortMenu();
        
        setupGps();
        
        inputText.delegate = self;
        inputText.layer.cornerRadius = 5;
        inputText.scrollEnabled = false;
        
        postDataInsert.delegate = self;
        
  
        setupCategory();

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillChangeFrameNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil);
    }
    
    override func viewDidAppear(animated: Bool) {
        //
        println("===> \(self.presentingViewController)");
    }
    
    override func setupCategory(){
        
        if let cc = rootvc!.category {
            cateChildBarbtn.title = cc.getSelectCategoryTag().tag;
        }
        
    }
    
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        println("textViewDidBeginEditing")
        
    }
    
    func textViewDidChange(textView: UITextView) {
        textView.layoutManager.ensureLayoutForTextContainer(textView.textContainer);
        var textBounds = textView.layoutManager.usedRectForTextContainer(textView.textContainer);
        
        var numLines = floor(textBounds.size.height / textView.font.lineHeight);
        
        if numLines > 3 {
            numLines = 3;
        }else{
            
        }
        
        println("numline \(numLines)");
        
        let th = numLines * 32;
        let ty = -(numLines - 1 ) * 32 + 6;
        
         println("numline \(numLines), th \(th)");
        
        var frm = textView.frame;
        frm.size.height = th;

        
        let th2 = numLines * 44;
        let ty2 = (numLines - 1 ) * 44;
        var frm2 = self.postInsertBar.bounds;
        frm2.size.height = th2;
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.LayoutSubviews, animations: {
            
                self.postInsertBar.bounds = frm2;
                textView.frame = frm;
            
            }, completion: { finished in
               //
                
        })
        
        
        if numLines >= 3 {
            
            textView.scrollEnabled  = true;
            
        }else  {
            textView.scrollEnabled  = false;
        }

    }
    
    func textViewDidEndEditing(textView: UITextView) {
        println("textViewDidEndEditing")
    }
    
    /**
    
    키보드 이벤트 헨들러
    */
    func keyboardWillShow(notification:NSNotification ) {
        
        println("### keyboardWillShow")
        //self.tbl.userInteractionEnabled = false;
        /**/
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIKeyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.CGRectValue().size;
        
        var h = kbSize.height - 49;
        
        let duration = info![UIKeyboardAnimationDurationUserInfoKey] as! Double;
        let curve = info![UIKeyboardAnimationCurveUserInfoKey] as! Int;
 //println(            self.postInsertBar.constraints());
        
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
        
        //self.tbl.userInteractionEnabled = true;

        
        let duration = info![UIKeyboardAnimationDurationUserInfoKey] as! Double;
        let curve = info![UIKeyboardAnimationCurveUserInfoKey] as! Int;
        //println(            self.postInsertBar.constraints());
        
        self.postInsertBarBottomMargin.constant = 0;
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: UInt(curve << 16)), animations: {
            //var bb = self.postInsertBar.bounds;
            //bb.origin.y = h;
            //self.postInsertBar.bounds = bb;
            self.postInsertBar.layoutIfNeeded();
            
            //
            }, completion: {finished in
                //
        });
        
        
        if h <= 0 { // 낮은 위치
            
            //
            
        }else{ // 높은 위치
            //
        }
        
        var contentInsets = UIEdgeInsetsMake(0, 0, h , 0);
        
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
        //var p = "long=\(gps.currentLocation!.coordinate.longitude)&";
        //p += "lat=\(gps.currentLocation!.coordinate.latitude)&"
        
        //var p = "long=126.9393889&";
        //p += "lat=37.5494730&";
        
        var p = "fromdate=" + searchParam.fromdate;
        p += "&todate=" + searchParam.todate;
        p += "&lat=" + searchParam.lat;
        p += "&long=" + searchParam.lng;
        p += "&category_name=" + searchParam.category;
        p += "&reSort=" + searchParam.sort;
        
        println("메인검색 파라미터 \(p)")
        
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
            
            searchParam.lat = "\(gps.currentLocation!.coordinate.latitude)";
            searchParam.lng = "\(gps.currentLocation!.coordinate.longitude)";
            
            self.requestData();
            initedGpsUpdate = true;
        }
    }
    
    override func refresh(target: UIBarButtonItem?) {
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
    
    @IBAction func onSort(sender: AnyObject) {
        
        println("\(selSort.selectedSegmentIndex)")
        
        searchParam.sort = selSort.selectedSegmentIndex == 0 ? "" : "like";
        self.requestData();

    }
    /**

*/
    func updateAfterSelectCategory(){
        

            if let cc = rootvc!.category{
                
                self.cateChildBarbtn.title =  cc.getSelectCategoryTag().tag;
                self.searchParam.category = cc.getSelectCategoryTag().value;
                self.requestData();
            }

    }
    
    @IBAction func onTouchCate(sender: AnyObject) {
        
        self.rootvc!.showCategory(self);
    }
    
    @IBAction func onTouchCate2(sender: AnyObject) {
        self.rootvc!.showCategory(self);
    }
    
    
    @IBAction func onPan(sender:AnyObject){
        println(sender);
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //self.performSegueWithIdentifier("SgPostDetail", sender: self);
        
        if inputText.isFirstResponder() {
            inputText.resignFirstResponder();
        }else{
            super.tableView(tableView , didSelectRowAtIndexPath: indexPath);
        }
    }

    @IBAction func onInsertDeail(sender: AnyObject) {
        self.showPostInsert(nil);

        if let postInsertIns = self.presentedViewController as? PostInsertVC {
            postInsertIns.gps = self.gps;
        }
    }
    @IBAction func onInsertShort(sender: AnyObject) {
        
        inputText.resignFirstResponder();
        
        var entity = EntityPostInfo();
        entity.memo = inputText.text;
        
        if let cc = rootvc!.category {
            
            entity.categoryCode = cc.getSelectCategoryTag().value;
            
        }
 
        
        entity.userId = "user5";
        
        if let g = gps{
            if let cl = g.currentLocation{
                entity.mapLng = String(format: "%.7f", cl.coordinate.longitude);
                entity.mapLat =  String(format: "%.7f", cl.coordinate.latitude);
            }
        }
        
        postDataInsert.send(entity, images: nil);
        
        
    }
    
    func onPostInsertStart() {
        //
        
        println("간략 업로드 시작")
        if alert == nil {
            alert = UIAlertController(title: "저장중", message: "잠시만 기다려주세요", preferredStyle: UIAlertControllerStyle.Alert)
        }
        
        if let aa = alert{
            self.presentViewController(aa, animated: true, completion: nil);
        }
        
    }
    
    func onPostInsertComplete() {
        //
        println("간략 업로드 끝")
        
        inputText.text = "";
        
        if let aa = alert{
            aa.dismissViewControllerAnimated(true, completion: { finished in
            
                var complete = UIAlertController(title: "성공", message: "저장되었습니다.", preferredStyle: UIAlertControllerStyle.Alert);
                complete.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: { action in
                    self.checkSuccess(complete);
                }));
                self.presentViewController(complete, animated: true, completion: nil)
            });
        }
        

    }
    
    func checkSuccess(sender:AnyObject){
        refresh(nil );
    }
    
    func onPostInsertFail() {
        //
    }
    
    func updteCategory(){
        
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
