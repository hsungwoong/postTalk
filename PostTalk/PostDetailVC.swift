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

    @IBOutlet var btnRecommand: UIButton!
    @IBOutlet var photoDummy: UIImageView!
    @IBOutlet var pagCtrl: UIPageControl!
    
    @IBOutlet var desc: UILabel!
    
    @IBOutlet var thumbnail: UIImageView!
    
    @IBOutlet var userId: UILabel!
    
    @IBOutlet var likeCnt: UILabel!
    
    @IBOutlet var timed: UILabel!
    
    @IBOutlet var scroll: UIScrollView!
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
        self.navigationItem.hidesBackButton = true;
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: UIBarButtonItemStyle.Plain , target: self, action: "hide:")
        //self.navigationItem.leftBarButtonItem?.title = "뒤로"
        
        self.pagCtrl.addTarget(self, action: "onSelectImage:", forControlEvents: UIControlEvents.TouchUpInside);
        
        btnRecommand.selected = true;
        
        desc.text = entity?.memo;
        desc.sizeToFit();
        
        userId.text = entity?.userId;
        
        if var imgName = entity?.img{
            if !imgName.isEmpty {
                photoDummy.imageFromUrl(ImageUrl.originPath + imgName)
            }
        }
        
    }
    
    func hide(sender:AnyObject){
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    override func  viewDidLayoutSubviews() {
        println("viewDidLayoutSubviews")
        scroll.contentSize = CGSizeMake(desc.frame.size.width, thumbnail.frame.origin.y + thumbnail.frame.size.height + 20 );
    
    }
    
    func onSelectImage(target:AnyObject?){
        
        
    }
    

    @IBAction func onRecomand(sender: AnyObject) {
    }
    
    @IBAction func onChatting(sender: AnyObject) {
    }
    
    @IBAction func onRegFriend(sender: AnyObject) {
    }

    @IBAction func onDelete(sender: AnyObject) {
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
