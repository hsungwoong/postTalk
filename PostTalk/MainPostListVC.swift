//
//  MainPostListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit


class MainPostListVC: BaseVC , IBaseDataAccessManager,  UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    
    var loader:DataMainPostLIst!;
    
    @IBOutlet var tbl: UITableView!
    
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
        
        //cateToolbar.delegate = self;
        
        /*
        var rec = cateToolbar.frame;
        rec.size.height = 40;
        cateToolbar.frame = rec;
        */
        
        //cateToolbar.setBackgroundImage(UIImage(named: "cate_toolbar_bg.png"), forToolbarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        //cateToolbar.
       
        cateToolbar.setBackgroundImage(UIImage(named: "cate_toolbar_bg.png"), forToolbarPosition: UIBarPosition.Bottom, barMetrics: UIBarMetrics.Default)
       // cateToolbar.
        
        //cateToolbar.setShadowImage( UIImage(named: "shadow.png") , forToolbarPosition: UIBarPosition.Top)
 /**/
        
      // cateToolbar.setShadowImage(UIImage(named: "shadow.png") , forToolbarPosition: UIBarPosition.Any)
        
        //var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate;
        //appDelegate.appManager;
        
        creatNaviBarRightButtons();
        
        // Do any additional setup after loading the view.
        tbl.delegate = self;
        tbl.dataSource = self;
        
        //cell등록
        var nib = UINib(nibName: "PostCell", bundle: nil)
        tbl.registerNib(nib, forCellReuseIdentifier: "PostCell")
        
        setupListMenu();
        
        //메인 목록 데이타 요청
        self.requestData();
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        println("scrollViewWillBeginDragging")
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        println("scrollViewWillBeginDecelerating")
        println(scrollView.contentOffset)
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        println("scrollViewDidEndScrollingAnimation")
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        println("scrollViewDidScrollToTop")
    }
    
    func setupListMenu() {
        
        cateBuletBarbtn.customView = UIImageView(image: UIImage(named: "bulet_cate.png"))
    }
    

    
    /**
        메인 데이타 요청 시작
*/
    func requestData(){
        if loader == nil {
            loader = DataMainPostLIst()
            loader.delegate = self;
        }
        println("# 메인 포스트 목록 데이타 api url :")
        println(APIUrl.mainList)
        loader.load(APIUrl.mainList);
    }
    
    /**
    메인 데이타 완료
*/
    func onLoadedData() {
        //
        println("onLoadedData at MainPostListVC")

        
        self.tbl.reloadData();
    }
    
    
    /**
    테이블 관련 소스
*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loader.total;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var entity:EntityPostInfo = loader.entities?[indexPath.row] as! EntityPostInfo;
        var str:String  = entity.memo!;
        
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, tableView.frame.width - 46, CGFloat.max));
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font =  UIFont(name: "Helvetica", size: 16.0)
        
        label.text = str;
        
        label.sizeToFit();
        
        return 93 + label.frame.height + 10;
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell;
        
        var entity:EntityPostInfo = loader.entities?[indexPath.row] as! EntityPostInfo;
        
        
        if indexPath.row % 2 == 0{
            cell.bg.backgroundColor = UIColor.whiteColor();

        }else{
            cell.bg.backgroundColor = UIColor(red: 255/255.0, green: 231/255.0, blue: 201/255.0, alpha: 1.0);

        }
        
        cell.userId.text = entity.userId!;
        
        if let cnt =  entity.likeCnt{
            cell.like.text = cnt
        }else{
            cell.like.text = "0";
        }
        
        //if let timed = entity.
        
        cell.desc.text = entity.memo!;
        
       
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SgGoMaintoDetail", sender: self);
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
