//
//  PostCell.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 28..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var bg: UIView!
    
    @IBOutlet var img: UIImageView!
    @IBOutlet var desc: UILabel!
    @IBOutlet var userId: UILabel!
    @IBOutlet var like: UILabel!
    @IBOutlet var passTimed: UILabel!
    
    var uid:String?;
    
    @IBOutlet var thumbNail: UIImageView!
    //var isOdd:Boolean = false;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.bg.layer.cornerRadius = 10;
        self.img.layer.cornerRadius = 25;
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadUserImgFromUrl(url:String){
        if img.image == nil{
            img.imageFromUrl(url);
        }
        
    }
    
    func loadImageFromUrl(url:String){
        if thumbNail.image == nil {
            thumbNail.imageFromUrl(url)
        }
        thumbNail.hidden = false;
    }
    
    func emptyImage(){
        thumbNail.image = nil;
        thumbNail.hidden = true;
        
        img.image = nil;
    }
    
}
