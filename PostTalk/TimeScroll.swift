//
//  TimeScroll.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 18..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class TimeScroll: UIScrollView {
    /**
        clip bound 이외 영역 터치 가능하게
    */
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        var view:UIView? = super.hitTest(point, withEvent: event);
        
        for subview in self.subviews
        {
            
            if view != nil && view!.userInteractionEnabled{
                break;
            }
            
            var newPoint = self.convertPoint(point, toView: subview as? UIView);
            view = subview.hitTest(newPoint, withEvent: event);
            
            //println("--hit test \(view)")

        }
        
        
        
        return view;
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            
            var view:UIView? ;
            
            let currentPoint = touch.locationInView(self);
            

            for subview in self.subviews
            {

                var newPoint = self.convertPoint(currentPoint, toView: subview as? UIView);
                view = subview.hitTest(newPoint, withEvent: event);
                
                //println("view \(view)")
                
                if view != nil{
                    var bb = subview as! Ballon;
                    //println("bb \(bb.time.text)");
                    if let tc = delegate as? TimeCell{
                        tc.didSelectItem(self, item: bb);
                    }
                    
                }

            }
            
        }
    }

}
