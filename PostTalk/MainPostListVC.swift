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
    

    var gps:GpsManager!;
    
    var initedGpsUpdate = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creatNaviBarRightButtons();
        
        setupSortMenu();
        
        setupGps();
    }
    
    override func getUrl() -> String? {
        return APIUrl.mainList;
    }
    
    override func getParams() -> String? {
        var p = "long=\(gps.currentLocation!.coordinate.longitude)&";
        p += "lat=\(gps.currentLocation!.coordinate.latitude)&"
        return p;
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
