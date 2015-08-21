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
        // Initialization code
        
        
        
        println("Time cEll");
        


   
    }
    
    func update(){
        
        data =  delegate?.timeCell(self , index: _index!);
        
        
        lbl.text = data?.dateType;
        
        
        // 기존 제거
        for view in self.scroll.subviews {
            view.removeFromSuperview()
        }
        
        if data == nil{
            return;
        }
        
        if let list =  data?.list {
            var total = list.count;
            
            var space:CGFloat = 20;
            var w:CGFloat = 100;
            var h:CGFloat = 114;
            
            var sx:CGFloat = 0.0;
            
            for var i = total - 1  ; i > -1 ; --i {
            
            
                var dd = list[i] as! EntityChart;
 
            
                var bal = Ballon(frame: CGRectMake(sx , 0, w, h) );
            
                bal.index = i;
                
                if let s = dd.predate {
                    bal.time.text = dd.predate!;
                }
            
                bal.cnt.text = "\(dd.count)";
                
                bal.bg.image = UIImage(named: "balonBg\(2 + i%2)");
            
            
                self.scroll.addSubview(bal);
            
                sx = sx + w + space;
            
            }
            
            var endPoint: (CGFloat) = sx - w - space;
            
            self.scroll.contentSize = CGSizeMake( sx , h);
            self.scroll.contentOffset = CGPoint(x:endPoint, y:0);
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
        
        var currentIndex = total - Int(scrollView.contentOffset.x / 120) - 1;
        
        if currentIndex > -1 {

            if let dd = data {
                if let lst = dd.list{
                    var item = lst[currentIndex] as! EntityChart;
                    if let dt = item.predate {
                        
                        if dd.dateType == "Y" {
                            delegate?.timeCell(self, index: index!, selFromdate: "\(dt)-01-01", selTodate: "\(dt)-12-31")
                        }else if dd.dateType == "M"{
                            println("dt \(dt)")
                            

                            if let md = NSDate().convertStringToDate(dt + "-01") {
                                println("dt \(md)");
                                delegate?.timeCell(self, index: index!, selFromdate: "\(md.year())-\(md.month())-01", selTodate: "\(md.year())-\(md.month())-31")
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
