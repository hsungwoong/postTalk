//
//  DataUserInfo.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 7..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class DataUserInfo: BaseDataAccessManager {
    
    override func parserJson(jsonResult: NSDictionary?) {
        //엔티티 배열 생성
        entities = [Any]();
        
        //println(jsonResult)
        
        if let orders:NSArray = jsonResult?["Orders"] as? NSArray {
            
            //println(orders)
            
            //아이템을 배열에 추가
            for item in orders{
                var entity = EntityUserInfo();
                entity.userId = item["USER_ID"] as? String;
                entity.userPwd = item["PWD"] as? String;
                entity.userName = item["UNAME"] as? String;
                entity.userPhoto = item["USER_PHOTO"] as? String;
                
                entities?.append(entity);
            }
        }//end if
        
    }
    
}
