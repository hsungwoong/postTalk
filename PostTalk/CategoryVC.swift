//
//  CategoryVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 9. 10..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class CategoryVC: BaseVC, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tbl: UITableView!
    

    static var Data: [EntityCategory] = [
        EntityCategory(no: "0", tag: "전체", value :"")
        ,EntityCategory(no: "1", tag: "맛집", value :"맛집")
        ,EntityCategory(no: "2", tag: "데이트", value :"데이트")
        ,EntityCategory(no: "3", tag: "카페", value :"카페")
        ,EntityCategory(no: "4", tag: "여행", value :"여행")
        ,EntityCategory(no: "5", tag: "일상", value :"일상")
        ,EntityCategory(no: "6", tag: "풍경", value :"풍경")
        ,EntityCategory(no: "7", tag: "쇼핑", value :"쇼핑")
        ,EntityCategory(no: "8", tag: "운동", value :"운동")
        ,EntityCategory(no: "9", tag: "예술", value :"예술")
        ,EntityCategory(no: "10", tag: "문화", value :"문화")
        ,EntityCategory(no: "11", tag: "도서", value :"도서")
        ,EntityCategory(no: "12", tag: "정치", value :"정치")
        ,EntityCategory(no: "13", tag: "사회", value :"사회")
        ,EntityCategory(no: "14", tag: "부동산", value :"부동산")
        ,EntityCategory(no: "15", tag: "기타", value :"기타")
    ];
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("CategoryVC", owner: self, options: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        println("\(self.view)");
        println(self.tbl);
        
        //self.tbl.layer.cornerRadius = 10;
        
        self.tbl.dataSource = self;
        self.tbl.delegate = self;
        self.tbl.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell");
        
        
        if tbl.indexPathForSelectedRow() == nil{
            tbl.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None);
        }


        // Do any additional setup after loading the view.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
 
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as! UITableViewCell;
        
        cell.textLabel?.text = CategoryVC.Data[indexPath.row].tag;
        
        cell.accessoryType = UITableViewCellAccessoryType.None;
        
        if let selIndex =  tableView.indexPathForSelectedRow(){
            if indexPath.row == selIndex.row {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
            }
        }
        

        
        return cell;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoryVC.Data.count;
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44;
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if let selIndex =  tableView.indexPathForSelectedRow(){
            if let selCell = tableView.cellForRowAtIndexPath( selIndex ) {
                selCell.accessoryType = UITableViewCellAccessoryType.None;
            }
        }

        
        if let  cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark;
        }
        
        return indexPath;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        

        
        //self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    /**
        현재 선택한 카테고리
    */
    func getSelectCategoryTag() -> EntityCategory{
        
        if self.tbl != nil{
            if let selIndex =  self.tbl.indexPathForSelectedRow(){
                return CategoryVC.Data[selIndex.row];
            }
        }

        return CategoryVC.Data[0]; //전체
    }
    
    @IBAction func close(sender: AnyObject) {
        //self.dismissViewControllerAnimated(true, completion: nil)
        rootvc!.hideCategory();
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
