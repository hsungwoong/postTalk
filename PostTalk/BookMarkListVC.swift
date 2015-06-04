//
//  BookMarkListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class BookMarkListVC: BaseVC {

    @IBAction func gotoMainPostList(sender: AnyObject) {
        
        
        
         var tabbar = self.view.window?.rootViewController as! UITabBarController;
        
        //println(tabbar)
        
        tabbar.selectedIndex = 0;

        
        
    }
    @IBAction func gotoCommonPostList(sender: AnyObject) {
        
        self.performSegueWithIdentifier("SgCommonPostList", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
