//
//  SearchMapVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit
//import MapKit
import CoreLocation
import GoogleMaps


class SearchMapVC: BaseVC, CLLocationManagerDelegate, IGpsManagerDelegate, UITableViewDataSource, UITableViewDelegate, ITimeCellDelegate,IBaseDataAccessManager, UISearchBarDelegate
{

    @IBOutlet var GmapView: GMSMapView!;
    var placesClient: GMSPlacesClient?;
    var locationManager: CLLocationManager!
    
    var gps:GpsManager!;
    
    var timeCellData = [EntityTimeCell]() ;
    
    @IBOutlet var timeTbl: UITableView!
    
    private var loaderYear:DataTimeChart = DataTimeChart();
    private var loaderMonth:DataTimeChart = DataTimeChart();
    private var loaderDay:DataTimeChart = DataTimeChart();
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchResultTbl: UITableView!
    var searchResults =  [AnyObject]();
    
    @IBOutlet var timeDummy: UIView!;
    @IBOutlet var timeConst: NSLayoutConstraint!;
    
    var selectCoordination:CLLocationCoordinate2D?;
    
    
    var useGps = true;
    
    var myMarker:GMSMarker?;
    var myPlace:GMSPlace?;
    
    var delegate:ISearchMapVcDelegate?;

    var isOpen = false;
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("SearchMapVC", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        searchBar.delegate = self;
        
        placesClient = GMSPlacesClient();
        
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
        //tt.fromdate =  "\(NSDate().year())-01-01";
        //tt.todate = "\(NSDate().year())-12-31";
        timeCellData.append(tt);
        
        tt = EntityTimeCell();
        //tt.fromdate =  "\(NSDate().year())-12-01";
        //tt.todate = "\(NSDate().year())-12-31";
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
        
        searchResultTbl.delegate = self;
        searchResultTbl.dataSource = self;
        searchResultTbl.hidden = true;
        searchResultTbl.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SearchCell");
        
        
        //var camera = GMSCameraPosition.cameraWithLatitude(-33.86,longitude: 151.20, zoom: 6)
        //var mapView = GMSMapView.mapWithFrame(CGRectMake(0, 0, 200, 200), camera: camera)
        //self.GmapView.myLocationEnabled = true;
       
        
   
        var marker = GMSMarker()
        //marker.position = location;
        //marker.draggable = true;
        //marker.title = "현재위치"
        marker.snippet = "현재위치"
        marker.map = self.GmapView;
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    func requestLoaderYear(){

        if let g = gps{
            if let cl = g.currentLocation{

                var p = "dateType=Y";
                //p += "&lat=37.5494730&long=126.9393889";
                if let pp = myPlace{
                    p += "&lat=\(pp.coordinate.latitude)&long=\(pp.coordinate.longitude)";
                }else{
                    if let curloc = gps.currentLocation {
                        p += "&lat=\(curloc.coordinate.latitude)&long=\(curloc.coordinate.longitude)";
                    }
                    
                }
                p += "&fromdate=" +  timeCellData[0].fromdate;
                p += "&todate=" + timeCellData[0].todate;//NSDate().toShortDateString();
                
                println("------")
                println(timeCellData[0].prevDate)
                println(timeCellData[0].fromdate)
                println(timeCellData[0].todate)
                println(timeCellData[0].nextDate)
                
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
                //p += "&lat=37.5494730&long=126.9393889";
                if let pp = myPlace{
                    p += "&lat=\(pp.coordinate.latitude)&long=\(pp.coordinate.longitude)";
                }else{
                    if let curloc = gps.currentLocation {
                        p += "&lat=\(curloc.coordinate.latitude)&long=\(curloc.coordinate.longitude)";
                    }
                    
                }
                p += "&fromdate=" +  timeCellData[1].fromdate;
                p += "&todate=" + timeCellData[1].todate;
                
                println("requestLoaderMonth param \(p)")
                
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
                //p += "&lat=37.5494730&long=126.9393889";
                
                if let pp = myPlace{
                    p += "&lat=\(pp.coordinate.latitude)&long=\(pp.coordinate.longitude)";
                }else{
                    if let curloc = gps.currentLocation {
                        p += "&lat=\(curloc.coordinate.latitude)&long=\(curloc.coordinate.longitude)";
                    }
                    
                }
                
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
                
                if let list = timeCellData[0].list{
                    if let la = list.first as? EntityChart{
                        timeCellData[1].fromdate = "\(la.predate!)-01-01";
                        timeCellData[1].todate = "\(la.predate!)-12-31";
                    }

                }
                

                //timeTbl.reloadData();
                
                
            }else if sender.id == 1{
                
                timeCellData[1].list = sender.entities;
                
                if let list = timeCellData[1].list{
                    if let la = list.first as? EntityChart{
                        timeCellData[2].fromdate = "\(la.predate!)-01";
                        timeCellData[2].todate = "\(la.predate!)-31";
                    }
                    
                }
                
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

        if scrollView == timeTbl{
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
        }
        


    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == timeTbl{
        
            let cell = tableView.dequeueReusableCellWithIdentifier("TimeCell", forIndexPath: indexPath) as! TimeCell;
        
            cell.delegate = self;
            cell.index = indexPath.row;
            cell.update();
        
            return cell;
            
        }else if tableView == searchResultTbl{
            let cell2 = tableView.dequeueReusableCellWithIdentifier("SearchCell", forIndexPath: indexPath) as! UITableViewCell;
            
            if let result:GMSAutocompletePrediction = searchResults[indexPath.row] as? GMSAutocompletePrediction{
                
                let regularFont = UIFont.systemFontOfSize(12);
                let boldFont = UIFont.boldSystemFontOfSize(12);
                
                let bolded = result.attributedFullText.mutableCopy() as! NSMutableAttributedString
                bolded.enumerateAttribute(kGMSAutocompleteMatchAttribute, inRange: NSMakeRange(0, bolded.length), options: nil) { (value, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                    let font = (value == nil) ? regularFont : boldFont
                    bolded.addAttribute(NSFontAttributeName, value: font, range: range)
                }
                
                //label.attributedText = bolded;
                
                if let lbl = cell2.textLabel{
                    lbl.attributedText = bolded;
                }
            }
            

            
            return cell2;
        }
        
        return UITableViewCell();
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == timeTbl{
            return 200;
        }
        return 44;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == timeTbl{
            return 3;
        }else if tableView == searchResultTbl{
            return searchResults.count;
        }
        return 3;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == searchResultTbl {
            if let result:GMSAutocompletePrediction = searchResults[indexPath.row] as? GMSAutocompletePrediction{
                println(result.placeID);
                var placeID = result.placeID;
                placesClient!.lookUpPlaceID(placeID, callback: { (place: GMSPlace?, error: NSError?) -> Void in
                    if let error = error {
                        println("lookup place id query error: \(error.localizedDescription)")
                        return
                    }
                    
                    if let place = place {
                         self.searchResultTbl.hidden = true;
                        
                        println("Place name \(place.name)")
                        println("Place address \(place.formattedAddress)")
                        println("Place placeID \(place.placeID)")
                        println("Place placeID \(place.coordinate.latitude)")
                        println("Place placeID \(place.coordinate.longitude)")
                        println("Place attributions \(place.attributions)")
                        
                        self.myPlace = place;
                        
                        
                        if let mk = self.myMarker{
                            mk.title = place.name
                            mk.position = place.coordinate;
                        }
                        
                        self.GmapView.animateToLocation(place.coordinate);
                        

                        
                        //return;
                        
                        //타임셀
                       
                        
                        var h = 0;
                        
                        let duration = 0.3;
                        let curve = 2;
                        //println(            self.postInsertBar.constraints());
                        
                        self.timeConst.constant = 0;
                        
                        UIView.animateWithDuration(duration, delay: 0.03, options: UIViewAnimationOptions(rawValue: UInt(curve << 16)), animations: {
                            
                            self.timeDummy.layoutIfNeeded();
                            
                            
                            }, completion: {finished in
                                self.requestLoaderYear();
                        });
                        
                    } else {
                        println("No place details for \(placeID)")
                    }
                })
                
       
                

            }
        }
    }
    
    
    /**

    타임셀 위윔자
*/
    func timeCell(timeCell: TimeCell, index:Int)->EntityTimeCell{
        
        return timeCellData[index];
    }
    
    func timeCell(timeCell: TimeCell, index:Int, selFromdate:String, selTodate:String){
        
        
        if  index == 0{
            timeCellData[0].selFromdate = selFromdate;
            timeCellData[0].selTodate = selTodate;
            
            timeCellData[1].fromdate = timeCellData[0].prevDate;
            timeCellData[1].todate = timeCellData[0].nextDate;
            
        }else if index == 1 {
            timeCellData[1].selFromdate = selFromdate;
            timeCellData[1].selTodate = selTodate;
            
            timeCellData[2].fromdate = timeCellData[1].prevDate;
            timeCellData[2].todate = timeCellData[1].nextDate;
        }else if index == 2 {
            
        }

    }
    
    func timeCell(timeCell: TimeCell , didSelectItem:Ballon , selFromdate:String, selTodate:String, dateType:String){


        var et = EntitySearch();
        et.fromdate = selFromdate;
        et.todate = selTodate;
        
        if let place = myPlace{
            et.lat = "\(place.coordinate.latitude)";
            et.lng = "\(place.coordinate.longitude)";
        }

        
        delegate?.requestSearch(et);
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
        
        if useGps {
            useGps = false;
        
            //var location = CLLocationCoordinate2DMake(37.5511443, 126.9433495)
            if let curloc = gps.currentLocation {
                var location = CLLocationCoordinate2DMake(curloc.coordinate.latitude , curloc.coordinate.longitude)
                
                self.GmapView.camera = GMSCameraPosition.cameraWithLatitude(location.latitude,longitude: location.longitude, zoom: 18);
        
                myMarker = GMSMarker(position: location)
                if let mk = myMarker{
                    mk.title = "현위치";
                    mk.map = self.GmapView;
                }
                

                
                
                self.openclose(self);
            }
        }
        /*

        */
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println(searchBar.text);
        
        placeAutocomplete(searchBar.text);
        
        self.searchBar.resignFirstResponder();
    }
    
    func placeAutocomplete(keyword : String) {
        
        println("keyword " +  keyword);
        //let visibleRegion = self.GmapView.projection.visibleRegion();
        //let bounds = GMSCoordinateBounds(coordinate: visibleRegion.farLeft, coordinate: visibleRegion.nearRight)
        
        let filter = GMSAutocompleteFilter();
        filter.type = GMSPlacesAutocompleteTypeFilter.Geocode;
        
        placesClient?.autocompleteQuery(keyword, bounds: nil, filter: filter, callback: { (results, error: NSError?) -> Void in
            if let error = error {
                println("Autocomplete error \(error)");
                return;
            }
            
            if let rr = results {
                self.searchResults = rr;
            }else{
                self.searchResults = [AnyObject]();
            }
            /*
            for result in results! {
                if let result:GMSAutocompletePrediction = result as? GMSAutocompletePrediction {
                    //println("Result \(result.attributedFullText) with placeID \(result.placeID)");
                    println("- Result: \(result.attributedFullText)");
                    
                }
            }
            */
            self.searchResultTbl.hidden = false;
            self.searchResultTbl.reloadData();
        })
    }

    @IBAction func openclose(sender: AnyObject) {
        
        self.isOpen = !self.isOpen;
       
        var h = self.isOpen ? 0 : -227;
        
        let duration = 0.3;
        let curve = 2;

        self.timeConst.constant = CGFloat( h);
        
        UIView.animateWithDuration(duration, delay: 0.03, options: UIViewAnimationOptions(rawValue: UInt(curve << 16)), animations: {
            
            self.timeDummy.layoutIfNeeded();
            
            
            }, completion: {finished in
                println("completion --------------->")
                println(" self.isOpen  \( self.isOpen )")
                self.requestLoaderYear();
        });/**/
        
        
        //현재위치를 중앙으로
        if let pp = myPlace{
            var vancouverCam = GMSCameraUpdate.setTarget(pp.coordinate)
            self.GmapView.animateWithCameraUpdate(vancouverCam)
        }else{
            if let curloc = gps.currentLocation {
                var vancouverCam = GMSCameraUpdate.setTarget(curloc.coordinate)
                self.GmapView.animateWithCameraUpdate(vancouverCam)
            }
            
        }
        
        //현재위치에서 위아래로
        var pan = self.isOpen ? 120.0 : -120.0;
        var downwards = GMSCameraUpdate.scrollByX(0, y: CGFloat ( pan ))
        self.GmapView.animateWithCameraUpdate(downwards)

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
