//
//  MainPostListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit


class MainPostListVC: CommonPostListVC{
 
    @IBOutlet var cateToolbar: UIToolbar!
    @IBOutlet var cateBuletBarbtn: UIBarButtonItem!
    @IBOutlet var cateChildBarbtn: UIBarButtonItem!
    
    @IBAction func onTouchCate(sender: AnyObject) {
    }
    
    @IBAction func onPan(sender:AnyObject){
        println(sender);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

       
        cateToolbar.setBackgroundImage(UIImage(named: "cate_toolbar_bg.png"), forToolbarPosition: UIBarPosition.Bottom, barMetrics: UIBarMetrics.Default)

        creatNaviBarRightButtons();
        

        
        setupListMenu();
        
        //메인 목록 데이타 요청
        self.requestData();
    }
    

    
    func setupListMenu() {
        
        cateBuletBarbtn.customView = UIImageView(image: UIImage(named: "bulet_cate.png"))
    }
    

    override func  prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let postDetail = segue.destinationViewController as? PostDetailVC{
            if let indexPath = self.tbl.indexPathForSelectedRow(){
                var entity = loader.entities?[indexPath.row] as! EntityPostInfo;
                postDetail.entity  = entity;
            }
            
        }
       
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
