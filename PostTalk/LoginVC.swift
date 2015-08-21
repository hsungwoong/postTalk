//
//  LoginVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class LoginVC: BaseVC, IBaseDataAccessManager {
    
    var loader:DataUserInfo!
    
    @IBOutlet var inputUserId: UITextField!
    @IBOutlet var inputPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "tapped:"))
    }
    
    func tapped(sender:UITapGestureRecognizer){
        println("tapped")
        //self.resignFirstResponder();
        if inputPwd.isFirstResponder() {
            inputPwd.resignFirstResponder();
        }
        
        if inputUserId.isFirstResponder(){
            inputUserId.resignFirstResponder();
        }
    }
    
    //로그인 check
    @IBAction func btnLoginChk(sender: AnyObject) {
        requestData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("LoginVC", owner: self, options: nil)
    }
    
    /**
    데이타 요청 시작
    */

    
    
    func requestData(){
        if loader == nil {
            loader = DataUserInfo()
            loader.delegate = self;
        }
         println("# 회원정보 api url :")
        loader.load( getUrl(), params: getParams() );
        
    }
    
    func getUrl() -> String?{
        //return nil;
        return APIUrl.userInfo;
    }
    
    func getParams() -> String? {
         var p = "USER_ID=\(inputUserId.text)&";
            p += "PWD=\(inputPwd.text)&"
        return p;
    }

    /**
    데이타 완료
    */
    func onLoadedData(sender: BaseDataAccessManager) {
        
        println("onLoadedData at LoginVC")
        
        var entity = loader.entities?[0] as! EntityUserInfo
        println("login_userid:"+entity.userId!)
        
        
        //로그인 성공하면 아이디 저장한다.
        if entity.userId != "" {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(entity.userId, forKey: "userId")
            inputUserId.text=""
            inputPwd.text=""
            //self.dismissViewControllerAnimated(true, completion: nil)//.dismissViewControllerAnimated(true, completion: nil)
            
            //var settingVC: SettingVC = self.storyboard?.instantiateViewControllerWithIdentifier("SettingVC") as! SettingVC

            //SettingVC; settingVC = new; SettingVC()
            //settingVC.initSettingLoad()
            self.tabBarController?.selectedIndex = 0;
            //self.navigationController!.popViewControllerAnimated(true)
            println("login ok")
            
        }
        else//다시 로그인 화면 초기화
        {
            inputUserId.text=""
            inputPwd.text=""
            
        }
        
        
        //self.getName.text = entity.userName!
        //self.getUserId.text = entity.userId!
        //println("username:"+entity.userPwd!);
        //postDetail.entity  = entity;
        
        //self.tbl.reloadData();
    }
    
    
    
    /*
    //ID 저장
    
    let defaults = NSUserDefaults.standardUserDefaults()
    defaults.setObject(txtTask.text, forKey: "userId")
    
    //저장된 아이디 정보값
    let defaults = NSUserDefaults.standardUserDefaults()
    if let name = defaults.stringForKey("userId")        {
    //println("test \(name)")
    txtSavedIdInfo.text = name
    }
    
    sample:cstone501, tjrkdeo
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
