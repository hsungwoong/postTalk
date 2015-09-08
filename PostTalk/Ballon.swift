//
//  Ballon.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 18..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class Ballon: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet var cnt: UILabel!
    @IBOutlet var time: UILabel!
    
    var index:Int?;
    var timeIndex:Int?;
    
    @IBOutlet var bg: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        NSBundle.mainBundle().loadNibNamed("Ballon", owner: self, options: nil)
        

        self.addSubview(self.view)
    }
}
