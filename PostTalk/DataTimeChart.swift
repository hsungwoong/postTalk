//
//  DataTimeChart.swift
//  PostTalk
//
//  Created by dykim on 2015. 8. 20..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class DataTimeChart: BaseDataAccessManager {
    override func parserJson(jsonResult: NSDictionary?) {
        
        //엔티티 배열 생성
        entities = [Any]();
        
        if let result:NSArray = jsonResult?["CHART"] as? NSArray {
  // println("---------------------")
  //          println(self.id )
//println(jsonResult)
            
            //아이템을 배열에 추가
            for item in result{
                var entity = EntityChart();
                entity.predate = item["PREDATE"] as? String;
                
                if let v: AnyObject? = item["COUNT"]{
                    let s = v as! String;
                    entity.count = s.toInt()!;

                }

                entities?.append(entity);
            }
        }//end if
        
    }
}
