//
//  MyPostListVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 15..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class MyPostListVC: CommonPostListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //메인 목록 데이타 요청
        self.requestData();
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
