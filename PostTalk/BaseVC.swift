//
//  BaseVCViewController.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 7..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class BaseVC: UIViewController, ISearchMapVcDelegate {
    
    var appMgr:AppManager?
    
    lazy var searchMap:SearchMapVC? =  SearchMapVC();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    /**
        네비바 우측 버튼 생성
*/
    func creatNaviBarRightButtons(){
        
        var buttons:[AnyObject] = [AnyObject]();

        buttons.append( createBarButton("barbutton_refresh", target: self, action: "refresh:") )
        buttons.append( createBarButtonSpace() )
        buttons.append( createBarButton("barbutton_map", target: self, action: "showMap:") )
        buttons.append( createBarButtonSpace() )
        buttons.append( createBarButton("barbutton_search", target: self, action: "showSearch:") )
        
        self.navigationItem.rightBarButtonItems = buttons;
        
    }
    
    func createPostInsertButton(){
        println("-------")
        println("createPostInsertButton");
        var button = createBarButton("barbutton_postwrite", target: self, action: "showPostInsert:")
        self.navigationItem.leftBarButtonItems = [button];
    }

    /**
        
     bar button 생성

*/
    func createBarButton(name:String, target:AnyObject? ,action:String) -> UIBarButtonItem{
        
        var child = UIButton(frame: CGRectMake(0, 0, 20, 20));
        child.setBackgroundImage(UIImage(named: name), forState: UIControlState.Normal);
        child.addTarget(target, action: Selector(action) , forControlEvents: UIControlEvents.TouchUpInside)
        var barButton = UIBarButtonItem(customView: child);

        return barButton;
    }
    
    /**
        bar button 사이 여백
*/
    func createBarButtonSpace() -> UIBarButtonItem{
        var button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
        button.width = 10;
        return button;
    }
    
    func refresh(target:UIBarButtonItem){
        println("## refresh ##")
    }
    
    func showMap(target:UIBarButtonItem){
        self.presentViewController(CurrentMapVC(), animated: true, completion: nil);
        //self.performSegueWithIdentifier("SgPostMapPre", sender: self);
        
        println("## show map ##")
    }
    
    func showSearch(target:UIBarButtonItem){
        
        if let vc = searchMap {
            vc.delegate = self;
            self.presentViewController(vc, animated: true, completion: nil);
        }
        
        //println("## search ##")
    }
    
    func requestSearch(et:EntitySearch){
        if let vc = searchMap {
            vc.dismissViewControllerAnimated(true, completion: nil);
            println(et);
            
            println(self.tabBarController)
            
            if  let tb = self.tabBarController {
                tb.selectedIndex = 0;
                println(tb.selectedViewController)
                if let nv = tb.selectedViewController as? UINavigationController{
                    if let first = nv.viewControllers.first as? MainPostListVC{
                        first.searchParam = et;
                        first.requestData();
                    }
                }

            }
            
            /*
            var tb = self.view.window?.rootViewController as! UITabBarController;
            tb.selectedIndex = 0;
            if let main = tb.selectedViewController as? MainPostListVC{
                println(main);
            }*/
        }
    }

    func showPostInsert(target:UIBarButtonItem?){
        println("#showPostInsert#")
        self.presentViewController(PostInsertVC(), animated: true, completion: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //로그인필요한 페이지 체크
    func openLoginChk()
    {
        //저장된 아이디 있을시 보여준다
        let defaults = NSUserDefaults.standardUserDefaults()
        let name = defaults.stringForKey("userId")
        //로그인 상황인 아니면 로그인페이지로 이동한다.
        println("userid:")
        println(name)
        if name == nil {
            let controller = LoginVC(nibName: "LoginVC", bundle: nil)
            self.navigationController!.pushViewController(controller, animated: true)
            //self.navigationController!.popViewControllerAnimated(true) //pushViewController(controller, animated: true)
        }
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
