//
//  PostInsertRootVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 24..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class PostInsertRootVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.pushViewController(PostInsertVC(), animated: true);
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
