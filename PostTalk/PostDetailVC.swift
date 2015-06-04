//
//  PostDetailVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostDetailVC: BaseVC {
    
    static var insCnt = 0;
    
    var entity:EntityPostInfo?;

    @IBAction func gotoPostMap(sender: AnyObject) {
        self.performSegueWithIdentifier("SgPostMap", sender: self)
    }
    /**/
    override func loadView() {
        
       // ++PostDetailVC.insCnt;
       // println("loadView \(PostDetailVC.insCnt), \(self)")
        
        NSBundle.mainBundle().loadNibNamed("PostDetailVC", owner: self, options: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatRightButton();
        
        println("idx: \(self.entity?.idx)");
        println("idx: \(self.entity?.memo)")
        // Do any additional setup after loading the view.
    }
    
    func creatRightButton(){
        
        var arr:[AnyObject] = [AnyObject]();
        
        
        //var button = UIBarButtonItem(image: UIImage(named: "barbutton_refresh"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        var img = UIImageView(image: UIImage(named: "barbutton_refresh"))
        img.frame = CGRectMake(0, 0, 20, 20);
        var button = UIBarButtonItem(customView: img);
        arr.append(button)
        
        button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        button.width = 10;
        arr.append(button)
        
        img = UIImageView(image: UIImage(named: "barbutton_map"))
        img.frame = CGRectMake(0, 0, 20, 20);
        button = UIBarButtonItem(customView: img);
        arr.append(button)
        
        button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        button.width = 10;
        arr.append(button)
        
        img = UIImageView(image: UIImage(named: "barbutton_search"))
        img.frame = CGRectMake(0, 0, 20, 20);
        button = UIBarButtonItem(customView: img);
        arr.append(button)
        /*
        
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spacer.width = -10; //
        */
        /*
        button = UIBarButtonItem(image: UIImage(named: "barbutton_map"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        button.customView?.frame = CGRectMake(0, 0, 22, 22);
        arr.append(button)
        
        button = UIBarButtonItem(image: UIImage(named: "barbutton_search"), style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        button.customView?.frame = CGRectMake(0, 0, 22, 22);
        arr.append(button)
        */
        
        
        self.navigationItem.rightBarButtonItems = arr;
        
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
