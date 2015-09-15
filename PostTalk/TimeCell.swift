//
//  TimeCell.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 7..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell, UIScrollViewDelegate {
    
    
    @IBOutlet var lbl: UILabel!;
    @IBOutlet var scroll: UIScrollView!;
    
    private var _index : Int?;
    
    var data:EntityTimeCell?;
    
    var delegate:ITimeCellDelegate?;
    
    var index : Int?{
        get{
            return _index;
        }
        set{
            
            //if newValue != _index {
                _index = newValue;
                
               
            //}
            

            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scroll.delegate = self;

    }
    
    func update(){
        
        data =  delegate?.timeCell(self , index: _index!);
        
        if let d = data{
            lbl.text = d.dateType;
            
            
            // 기존 제거
            for view in self.scroll.subviews {
                view.removeFromSuperview()
            }
            
            
            if let list =  d.list {
                var total = list.count;
                
                var space:CGFloat = 0;
                var w:CGFloat = 70;
                var h:CGFloat = 114;
                
                var sx:CGFloat = 0.0;
                
                for var i = total - 1  ; i > -1 ; --i {
                    
                    
                    var dd = list[i] as! EntityChart;
                    
                    
                    var bal = Ballon(frame: CGRectMake(sx , 0, w, h) );
                    
                    bal.index = i;
                    bal.timeIndex = _index;
                    
                    if let s = dd.predate {
                        bal.time.text = dd.predate!;
                    }
                    
                    bal.cnt.text = "\(dd.count)";
                    
                    bal.bg.image = UIImage(named: "balonBg");
                    
                    
                    self.scroll.addSubview(bal);
                    
                    sx = sx + w + space;
                    
                   // NSDate.convertStringToDate(dd.predate!)
                    
                }
                
                var endPoint: (CGFloat) = CGFloat( data!.cidx) * w;//sx - w - space;
                
                self.scroll.contentSize = CGSizeMake( sx , h );
                self.scroll.contentOffset = CGPoint(x:endPoint, y:0);
            }

        }
    }
    
    
    func didSelectItem(sender:TimeScroll, item:Ballon){
        var data =  delegate?.timeCell(self , index: item.timeIndex!);
        if let d = data{
            if let list = d.list{
                if let idx = item.index{
                    var o = list[idx] as! EntityChart;
                    var pd = o.predate!
                    
                    var fromDate = "";
                    var toDate = "";
                    
                    if let dt = d.dateType {
                        if dt == "Y" {
                            fromDate = "\(pd)-01-01";
                            toDate =  "\(pd)-12-31";
                        }else if dt == "M"{
                            fromDate = "\(pd)-01";
                            
                            if let fd = NSDate().convertStringToDate(fromDate){
                                toDate = fd.lastDateOfTheMonth().toShortDateString();
                            }
                            
                        }else if dt == "D"{
                            fromDate = pd;
                            toDate =  pd;
                        }
                        
                        if let dg = delegate{
                            dg.timeCell(self, didSelectItem: item, selFromdate: fromDate, selTodate: toDate, dateType: dt);
                        }
                    }

                    
                }
                
            }
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
        //println("scroll end")
        
        if !decelerate{
            scrollViewDidEndDecelerating(scrollView);
        }
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        println("-----end")
        
        
        var total = 0;
        if let lst = data?.list{
            total =  lst.count;
        }
        
        var currentIndex = total - Int(scrollView.contentOffset.x / 70) - 1;
        
        if currentIndex > -1 {

            if let dd = data {
                
                if let lst = dd.list{
                    
                    var item = lst[currentIndex] as! EntityChart;
                    
                    if let dt = item.predate {
                        
                        if dd.dateType == "Y" {
                            
                            delegate?.timeCell(self, index: index!, selFromdate: "\(dt)-01-01" , selTodate: "\(dt)-12-31" );
                            
                        }else if dd.dateType == "M"{
                            
                            println("dt \(dt)")
                            

                            if let md = NSDate().convertStringToDate(dt + "-01") {
                         
                                delegate?.timeCell(self, index: index!, selFromdate: md.toShortDateString(), selTodate: md.lastDateOfTheMonth().toShortDateString())
                            }
                            
                        }else if dd.dateType == "D"{
                            

                        }
                    }
                }
            }

        }
        
        println("currentIndex \(currentIndex)");
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
