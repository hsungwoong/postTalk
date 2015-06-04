//
//  AppManager.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 7..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import UIKit

class AppManager: NSObject {
    private static var _instance:AppManager!;
    
    static func getInstance() -> AppManager{
        if _instance == nil {
            _instance = AppManager();
        }
        
        return _instance;
    }
    
    
    
    
}
