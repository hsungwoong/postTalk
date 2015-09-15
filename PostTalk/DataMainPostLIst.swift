//
//  DataMainPostLIst.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 7..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class DataMainPostLIst: BaseDataAccessManager {
    
    override func parserJson(jsonResult: NSDictionary?) {
        //엔티티 배열 생성
        entities = [Any]();
        //println("******************")
        //println(jsonResult)

        if let orders:NSArray = jsonResult?["Main"] as? NSArray {
            
             //println(orders)
            
            //아이템을 배열에 추가
            for item in orders{
                var entity = EntityPostInfo();
                entity.idx = item["IDX"] as? String;
                entity.img = item["IMAGE_NAME"] as? String;
                entity.memo = item["MEMO"] as? String;
                entity.userId = item["USER_ID"] as? String;
                entity.insDate = item["INS_DATE"] as? String;
                entity.likeCnt = item["LIKE_CNT"] as? String;
                entity.viewCnt = item["VIEW_CNT"] as? String;
                entity.userImg = item["IMAGE_MAIN_NAME"] as? String;
                entity.cateName = item["CATEGORY_NAME"] as? String;
                entities?.append(entity);
            }
        }//end if
        
    }
   
}
