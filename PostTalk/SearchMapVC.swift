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

class SearchMapVC: BaseVC, CLLocationManagerDelegate, IGpsManagerDelegate, UITableViewDataSource, UITableViewDelegate, ITimeCellDelegate,IBaseDataAccessManager
{
    @IBOutlet var Map: MKMapView!
    var locationManager: CLLocationManager!
    
    var gps:GpsManager!;
    
    var timeCellData = [EntityTimeCell]() ;
    
    @IBOutlet var timeTbl: UITableView!
    
    private var loaderYear:DataTimeChart = DataTimeChart();
    private var loaderMonth:DataTimeChart = DataTimeChart();
    private var loaderDay:DataTimeChart = DataTimeChart();
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("SearchMapVC", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupGps();
        
        var nib = UINib(nibName: "TimeCell", bundle: nil);
        timeTbl.registerNib(nib, forCellReuseIdentifier: "TimeCell");
        
        /*
        EntityTimeCell 초기화
        */
        var tt = EntityTimeCell();
        tt.dateType = "Y";
        tt.fromdate =  NSDate().OffsetByYear(-5);
        tt.todate = NSDate().toShortDateString();
        timeCellData.append(tt);
        
        tt = EntityTimeCell();
        tt.dateType = "M";
        timeCellData.append(tt);
        
        tt = EntityTimeCell();
        tt.dateType = "D";
        timeCellData.append(tt);
        
        
        /**
            데이타 로더 생성
        */
        loaderYear.delegate = self;
        loaderYear.id = 0;
        

        loaderMonth.id = 1;
        loaderMonth.delegate = self;
        

        loaderDay.id = 2;
        loaderDay.delegate = self;
        
        timeTbl.delegate = self;
        timeTbl.dataSource = self;
        
    }
    
    func requestLoaderYear(){

        if let g = gps{
            if let cl = g.currentLocation{

                var p = "dateType=Y";
                //p += "&lat=" + String(format: "%.7f", cl.coordinate.latitude);
                //p += "&long=" + String(format: "%.7f", cl.coordinate.longitude);
                p += "&lat=37.5494730&long=126.9393889";
                p += "&fromdate=" +  timeCellData[0].fromdate;
                p += "&todate=" + timeCellData[0].todate;//NSDate().toShortDateString();
                
                loaderYear.load(APIUrl.chartList, params: p)
            }
        }
    }
    
    func requestLoaderMonth(){

        if let g = gps{
            if let cl = g.currentLocation{
                
                var p = "dateType=M";
                //p += "&lat=" + String(format: "%.7f", cl.coordinate.latitude);
                //p += "&long=" + String(format: "%.7f", cl.coordinate.longitude);
                p += "&lat=37.5494730&long=126.9393889";
                p += "&fromdate=" +  timeCellData[1].fromdate;
                p += "&todate=" + timeCellData[1].todate;
                
                loaderMonth.load(APIUrl.chartList, params: p)
            }
        }
    }
    
    func requestLoaderDay(){

        if let g = gps{
            if let cl = g.currentLocation{
                
                var p = "dateType=D";
                //p += "&lat=" + String(format: "%.7f", cl.coordinate.latitude);
                //p += "&long=" + String(format: "%.7f", cl.coordinate.longitude);
                p += "&lat=37.5494730&long=126.9393889";
                p += "&fromdate=" +  timeCellData[2].fromdate;
                p += "&todate=" +  timeCellData[2].todate;
                
                loaderDay.load(APIUrl.chartList, params: p)
            }
        }
    }
    
    func onLoadedData(sender: BaseDataAccessManager) {
        
        
        if let mycell = timeTbl.cellForRowAtIndexPath( NSIndexPath(forRow: sender.id!, inSection: 0) ) as? TimeCell{
            
            if sender.id == 0{
                
                timeCellData[0].list = sender.entities;
                //timeTbl.reloadData();
                
                
            }else if sender.id == 1{
                
                timeCellData[1].list = sender.entities;
                
                
                
            }else if sender.id == 2 {
                
                timeCellData[2].list = sender.entities;
                
                
                
            }
            
            mycell.update();
            
        }
        


    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        //
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        //

    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //
        //println("scroll 1")
        if !decelerate{
            scrollViewDidEndDecelerating(scrollView);
        }

    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //
        //println("scroll 2")
        
        var cell: TimeCell = timeTbl.visibleCells().last as! TimeCell;
        
        if let idx = cell.index{
            if idx == 0{
                requestLoaderYear();
            }else if idx == 1{
                requestLoaderMonth();
            }else if idx == 2{
                requestLoaderDay();
            }
        }
        println(cell.index!);
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeCell;
        
        cell.delegate = self;
        cell.index = indexPath.row;
        cell.update();
        
        return cell;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    
    /**

    타임셀 위윔자
*/
    func timeCell(timeCell: TimeCell, index:Int)->EntityTimeCell{
        
        return timeCellData[index];
    }
    
    func timeCell(timeCell: TimeCell, index:Int, selFromdate:String, selTodate:String){
        
        //return timeCellData[index];
        println("fromdate : \(selFromdate)")
        println("todate : \(selTodate)")
        
        if  index == 0{
            timeCellData[0].selFromdate = selFromdate;
            timeCellData[0].selTodate = selTodate;
            
            timeCellData[1].fromdate = selFromdate;
            timeCellData[1].todate = selTodate;
            
        }else if index == 1 {
            timeCellData[1].selFromdate = selFromdate;
            timeCellData[1].selTodate = selTodate;
            
            timeCellData[2].fromdate = selFromdate;
            timeCellData[2].todate = selTodate;
        }else if index == 2 {
            
        }

    }
    
    
    
    
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
        
        /**
            년도 데이타
        */
        requestLoaderYear();
        
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
