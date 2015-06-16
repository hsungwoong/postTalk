//
//  SettingVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 4. 30..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class SettingVC: BaseVC, IBaseDataAccessManager, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var loader:DataUserInfo!
    var languageGbn = ["국문","영문","중문","일문"] // 어권 picker view list
    
    
    @IBOutlet var getName: UILabel!
    @IBOutlet var getUserId: UILabel!
    @IBOutlet var txtPwd: UITextField!
    @IBOutlet var autoLogin: UISwitch!
    @IBOutlet var getUserImage: UIImageView!
    @IBOutlet var getLanguagePickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLanguagePickerView.dataSource = self;
        self.getLanguagePickerView.delegate = self;
        
        openLoginChk() //로그인체크
        requestData() //회원정보 데이타 가져오기
        
        // Do any additional setup after loading the view.
    }
    
    
    //로그인 페이지 팝업 띄우기
    /*
    @IBAction func openLoginVC(sender: AnyObject) {
    //NSBundle.mainBundle().loadNibNamed("LoginVC", owner: self, options: nil)
    
    //viewcontroller에서 다른 viewcontroller로 이동
    let controller = LoginVC(nibName: "LoginVC", bundle: nil)
    self.navigationController!.pushViewController(controller, animated: true)
    
    //var loginController: LoginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
    //var loginController: LoginVC = self.nibName..instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
    //self.presentViewController(loginController, animated: true, completion: nil)
    }
    
    @IBAction func gotoMyInfo(sender: AnyObject) {
    
    self.performSegueWithIdentifier("SgMyInfo", sender: self)
    }
    
    @IBAction func gotoLangChange(sender: AnyObject) {
    self.performSegueWithIdentifier("SgLangChange", sender: self)
    }
    */
    
    
    override func loadView() {
        NSBundle.mainBundle().loadNibNamed("SettingVC", owner: self, options: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
    데이타 요청 시작1
    */
    func requestData(){
        if loader == nil {
            loader = DataUserInfo()
            loader.delegate = self;
        }
        println("# 세팅 포스트 회원정보 api url :")
        println(APIUrl.userInfo)
        //loader.load(APIUrl.userInfo+"?USER_ID=cstone501");
    }
    
    /**
    데이타 완료
    */
    func onLoadedData() {
        
        println("onLoadedData at SettingVC")
        
        var entity = loader.entities?[0] as! EntityUserInfo
        self.getName.text = entity.userName!
        self.getUserId.text = entity.userId!
        self.txtPwd.text = entity.userPwd!
        self.autoLogin.setOn(false, animated: true)
        load_image(APIHost.live+"IMAGES/"+entity.userPhoto!)
        
        
        //저장된 아이디 있을시 보여준다
        let defaults = NSUserDefaults.standardUserDefaults()
        if let name = defaults.stringForKey("userId") {
            self.getName.text = entity.userName!+"["+name+"]"
        }
        
        //println("username:"+entity.userPwd!);
        //postDetail.entity  = entity;
        
        //self.tbl.reloadData();
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.languageGbn.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return self.languageGbn[row]
    }
    
    
    func load_image(urlString:String)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    self.getUserImage.image = UIImage(data: data)
                }
        })
        
    }
    
    
    
}
