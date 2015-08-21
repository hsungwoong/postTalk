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

        }
        
        return view;
    }

}
