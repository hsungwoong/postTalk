//
//  RootVC.swift
//  PostTalk
//
//  Created by dykim on 2015. 9. 10..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class RootVC: UITabBarController {
    
    lazy var category:CategoryVC? = CategoryVC();
    
    var usingCategory:BaseVC?;
    /*
    var savingAlert:UIAlertController?;
    
    
    func showSavingAlert(){
        if (savingAlert == nil){
            savingAlert = UIAlertController(title: "저장중", message: "잠시만 기다려주세요", preferredStyle: UIAlertControllerStyle.Alert);
            
        }
        
        if let aa = savingAlert{
            self.presentViewController( aa, animated: true, completion: nil);
        }
    }
    
    func hideSavingAlert(){
        
        if let aa = savingAlert {
            aa.dismissViewControllerAnimated(true, completion: { finished in
                
                var complete = UIAlertController(title: "성공", message: "저장되었습니다.", preferredStyle: UIAlertControllerStyle.Alert);
                complete.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: { action in
                    self.checkSuccess(complete);
                }));
                self.presentViewController(complete, animated: true, completion: nil)
            });
        }
    }
    */
    func checkSuccess(alert:UIAlertController){
        
    }
    
    func showCategory(sender:BaseVC?){
        
        self.usingCategory = sender;
        

        self.presentViewController(self.category!, animated: true, completion: nil);
    }
    
    func hideCategory(){
        if let cc = category {

            
            cc.dismissViewControllerAnimated(true, completion: { finished in
                
                println("finished \(finished)");
                
                if let u =  self.usingCategory as? MainPostListVC {
                    if let cc = self.category{
                        u.updateAfterSelectCategory();
    
                    }
  
                    //self.usingCategory = nil;
                }
               
                
            })
        }
    }
    
    
}
