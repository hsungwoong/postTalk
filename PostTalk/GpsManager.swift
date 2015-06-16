//
//  GpsManager.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 16..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit
import CoreLocation



class GpsManager: NSObject, CLLocationManagerDelegate {
    //private static var _instance:GpsManager!;
    
    var delegate:IGpsManagerDelegate?;
    
    var locMgr:CLLocationManager = CLLocationManager();
    
    var currentLocation:CLLocation?;
    
    /*
    static func getInstance() -> GpsManager{
        if _instance == nil {
            _instance = GpsManager();
        }
        
        return _instance
    }
*/
    
    override init() {
   
        super.init();
        
        println("###########")
        println("GpsManager init")
        
        CLLocationManager.significantLocationChangeMonitoringAvailable();
        
        locMgr.delegate = self;
        locMgr.desiredAccuracy = kCLLocationAccuracyBest;
        locMgr.distanceFilter = kCLDistanceFilterNone;
        
    }
    
    /*
    override func addObserver(observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions, context: UnsafeMutablePointer<Void>) {
    //
    }
    
    override func removeObserver(observer: NSObject, forKeyPath keyPath: String) {
    //
    }
    */
    
    private func requestAuth(){
        println("###########")
        println("GpsManager requestAuth")
        locMgr.requestWhenInUseAuthorization();
        //locMgr.
    }
    
    func start(){
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
            
            requestAuth();
            
            return;
        }
        
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Denied{
            
            println("###########")
            println("GpsManager start")
            
            locMgr.startUpdatingLocation();
            
            delegate!.onGpsDidStart?();
        }else{
            
            var alert = UIAlertView(title: "에러", message: "위치사용이 허용되지 않았습니다. 사용하려면 설정 화면>post talk> 위치에서 활성화 시켜주세요", delegate: nil, cancelButtonTitle: "ok");
            alert.show();
            
            delegate!.onGpsAuthDeny?()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        println("### didChangeAuthorizationStatus ###")
        switch status {
        case .NotDetermined :
            println("NotDetermined")
        case .AuthorizedWhenInUse :
            println("AuthorizedWhenInUse")
            self.start();
        case .Denied :
            println("Denied")
            locMgr.requestWhenInUseAuthorization();
        default :
            println("nothing")
        }
    }
    
    func locationManagerDidResumeLocationUpdates(manager: CLLocationManager!) {
        //
    }
    
    func locationManagerDidPauseLocationUpdates(manager: CLLocationManager!) {
        //
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var location = locations.last as? CLLocation;
        var eventDate = location?.timestamp;
        var howRecent = eventDate?.timeIntervalSinceNow;
        if abs(howRecent!) < 15{
            //location.coordinate.latitude;
            //location.coordinate.longitude;
            self.currentLocation = location;
            println("######user current location ####")
            println(self.currentLocation!)
        }
    }


    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        //
    }
    
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        //
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        //
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        //
    }
}
