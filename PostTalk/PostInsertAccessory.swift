//
//  PostInsertAccessory.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 23..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostInsertAccessory: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet var toolbar: UIToolbar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        /*
        var container = UIView(frame: CGRectMake(0,0 , UIScreen.mainScreen().bounds.width, 49));
        var toolbar = UIToolbar(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 49));
        
        var but = UIBarButtonItem(title: "좌측", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        var but1 = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        var but2 = UIBarButtonItem(title: "우측", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        
        toolbar.items = [but,but1, but2];
        container.addSubview(toolbar);
        self.addSubview(container);
        
        //var arr = NSBundle.mainBundle().loadNibNamed("PostInsertAccessory", owner: self, options: nil)
        
        //arr[0]
        */

        
        NSBundle.mainBundle().loadNibNamed("PostInsertAccessory", owner: self, options: nil)
        

        
        toolbar.frame = self.bounds;
        
        self.addSubview(self.toolbar)
       

    }
 
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
