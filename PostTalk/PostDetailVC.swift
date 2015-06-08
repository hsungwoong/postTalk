//
//  PostDetailVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostDetailVC: BaseVC {
    
    var entity:EntityPostInfo?;

    @IBOutlet var photoDummy: UIImageView!
    @IBOutlet var pagCtrl: UIPageControl!
    
   /* @IBAction func gotoPostMap(sender: AnyObject) {
        self.performSegueWithIdentifier("SgPostMap", sender: self)
    }
*/
    /**/
    override func loadView() {
        
       // ++PostDetailVC.insCnt;
       // println("loadView \(PostDetailVC.insCnt), \(self)")
        
        NSBundle.mainBundle().loadNibNamed("PostDetailVC", owner: self, options: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.pagCtrl.addTarget(self, action: "onSelectImage:", forControlEvents: UIControlEvents.TouchUpInside);
        
        // Do any additional setup after loading the view.
    }
    
    func onSelectImage(target:AnyObject?){
        
        
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
