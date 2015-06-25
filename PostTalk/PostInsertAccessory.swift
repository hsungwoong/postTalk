//
//  PostInsertAccessory.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 23..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostInsertAccessory: UIView {
    
    //@IBOutlet var view: UIView!
    
    @IBOutlet var imgBar: UIView!
    
    @IBOutlet var toolbar: UIToolbar!
    
    @IBOutlet var thumbNail: UIImageView!
    
    //var delegate:IPos
    //var delegate:
    var delegate:IPostInsertAccessoryDelegate?;
    
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
        
        self.imgBar.frame = CGRectMake(0, 0, self.bounds.width, 80);
        self.imgBar.hidden = true;
        
        self.addSubview(self.imgBar)
        
        toolbar.frame = self.bounds;
        self.addSubview(self.toolbar)
    }
 
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBAction func onTouchAlbum(sender: AnyObject) {
        
        self.delegate?.selectAlbum(self)
    }
    @IBAction func onTouchSend(sender: AnyObject) {
        println("onTouchSend")
        self.delegate?.sendPost(self)
    }

    @IBAction func onTouchCamera(sender: AnyObject) {
        self.delegate?.openCamera(self);
    }
    
    func addImage(img:UIImage){
        self.thumbNail.image = img;
    }
    
    func showImgBar(){
        println(">>> showImgBar")
        var fr = self.imgBar.bounds;
        //fr.offset(dx: 0, dy: 80)
        fr.origin.y = 80;
        self.imgBar.bounds = fr;
        self.imgBar.hidden = false;
        
    }
    
    func hideImgBar(){
        println(">>> hideImgBar")
        var fr = self.imgBar.bounds
        fr.origin.y = 0;
        self.imgBar.bounds = fr;
        self.imgBar.hidden = true;
    }
    
    func isVisibleImgBar() ->Bool{
        ///println("isVisibleImgBar \(self.imgBar.hidden)")
        return !self.imgBar.hidden
    }
    
    func isIncludeImg()->Bool{
       
        if thumbNail.image != nil {
            return true;
        }
        
        return false;
    }
    
    func unvisibleKB() {
        var win =  UIApplication.sharedApplication().windows.last as! UIWindow;
        // win.hidden = true;
        
        for  ww in UIApplication.sharedApplication().windows {
            println(ww)
            for vv in ww.subviews{
                
                
                if NSStringFromClass(vv.classForCoder) == "UIInputSetContainerView" {
                    println("-->\(NSStringFromClass(vv.classForCoder))");
                    if var vvv = vv as? UIView {
                        //vvv.hidden = true;
                        for oo in vvv.subviews{
                            //println("==>\(oo)")
                            if NSStringFromClass(oo.classForCoder) == "UIInputSetHostView" {
                                if var ooo = oo as? UIView{
                                    //ooo.hidden = true;
                                    for aa in ooo.subviews{
                                        println("==>\(aa)")
                                        
                                        if NSStringFromClass(aa.classForCoder) == "_UIKBCompatInputView" || NSStringFromClass(aa.classForCoder) == "UIKBInputBackdropView" {
                                            if var aaa = aa as? UIView{
                                                aaa.hidden = true;
                                                aaa.userInteractionEnabled = false;
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //
                }
                
            }
        }
    }
    
    func visibleKB() {
        var win =  UIApplication.sharedApplication().windows.last as! UIWindow;
        // win.hidden = true;
        
        for  ww in UIApplication.sharedApplication().windows {
            println(ww)
            for vv in ww.subviews{
                
                
                if NSStringFromClass(vv.classForCoder) == "UIInputSetContainerView" {
                    println("-->\(NSStringFromClass(vv.classForCoder))");
                    if var vvv = vv as? UIView {
                        //vvv.hidden = true;
                        for oo in vvv.subviews{
                            //println("==>\(oo)")
                            if NSStringFromClass(oo.classForCoder) == "UIInputSetHostView" {
                                if var ooo = oo as? UIView{
                                    //ooo.hidden = true;
                                    for aa in ooo.subviews{
                                        println("==>\(aa)")
                                        
                                        if NSStringFromClass(aa.classForCoder) == "_UIKBCompatInputView" || NSStringFromClass(aa.classForCoder) == "UIKBInputBackdropView" {
                                            if var aaa = aa as? UIView{
                                                aaa.hidden = false;
                                                aaa.userInteractionEnabled = true;
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                    //
                }
                
            }
        }
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
