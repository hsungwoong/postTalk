//
//  CommonPostListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class CommonPostListVC: BaseVC , UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate , IBaseDataAccessManager{
    
    @IBOutlet var tbl: UITableView!
    
    var totalItems = 0;
     var loader:DataMainPostLIst!;
    
    /*
    override func loadView() {
     NSBundle.mainBundle().loadNibNamed("CommonPostListVC", owner: self, options: nil)
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView();

        // Do any additional setup after loading the view.
    }
    
    func setupTableView(){
        // Do any additional setup after loading the view.
        self.tbl.delegate = self;
        self.tbl.dataSource = self;
        
        //cell등록
        var nib = UINib(nibName: "PostCell", bundle: nil)
        tbl.registerNib(nib, forCellReuseIdentifier: "PostCell")
        
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
        
        totalItems = loader.total;
        
        self.tbl.reloadData();
    }
    
    
    
    /**
    테이블 관련 소스
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return totalItems;
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return loader.total;
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        var entity:EntityPostInfo = loader.entities?[indexPath.section] as! EntityPostInfo;
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
        
        var entity:EntityPostInfo = loader.entities?[indexPath.section] as! EntityPostInfo;
        
        
        if indexPath.section % 2 == 0{
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

        
        cell.desc.text = entity.memo!;
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //var v = view as! UITableViewHeaderFooterView;
        //v.contentView.backgroundColor  = UIColor.clearColor();
    }
    
    func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        //var v = view as! UITableViewHeaderFooterView;
        //v.contentView.backgroundColor  = UIColor.clearColor();
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var v = UIView();
        return v;
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        var v = UIView();
        return v;
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5;
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var vv = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "삭제", handler: {
            action, indexPath in
                //
        })
        
        return [vv];
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SgGoMaintoDetail", sender: self);
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
