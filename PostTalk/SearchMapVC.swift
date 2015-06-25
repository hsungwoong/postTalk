//
//  SearchMapVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SearchMapVC: BaseVC, CLLocationManagerDelegate, IGpsManagerDelegate {

    
    @IBOutlet var Map: MKMapView!
    var locationManager: CLLocationManager!
    
    var gps:GpsManager!;
    
    //닫기
    @IBAction func btnClose(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil);
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
        //var location = CLLocationCoordinate2DMake(37.5511443, 126.9433495)
        if let curloc = gps.currentLocation {
            var location = CLLocationCoordinate2DMake(curloc.coordinate.latitude , curloc.coordinate.longitude)
            
            //var location = CLLocationCoordinate2DMake(gps.currentLocation?.coordinate.latitude , gps.currentLocation?.coordinate.longitude)
            
            var span = MKCoordinateSpanMake(0.0002, 0.0002)//확대 축소 비율
            var region = MKCoordinateRegion(center: location, span: span)//위치세팅
            
            Map.setRegion(region, animated: true)
            
            var annotation = MKPointAnnotation()
            //annotation.set.coordinate(location)
            //annotation.setCoordinate(location)
            annotation.title = "서강대"
            annotation.subtitle = "Coffee bean"
            Map.addAnnotation(annotation)
        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupGps()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("SearchMapVC", owner: self, options: nil)
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
