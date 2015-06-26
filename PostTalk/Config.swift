//
//  Config.swift
//  PostTalk
//
//  Created by dykim on 2015. 5. 28..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import Foundation



struct APIHost {
    
    static let live = "http://52.68.46.70/";
    static let dev = "http://52.68.46.70/";
    
    static var host:String{
        var ret:String;
        #if DEBUG
            ret = APIHost.dev;
        #else
            ret = APIHost.live;
        #endif
        
        return ret;
    }
}

struct APIUrl {
    static let mainList = APIHost.host + "post_list.php"; //hsw 20150624 add
    static let bookMarkFriendList = APIHost.host + "bookmark_friend_list.php"; //hsw 20150625 add
    static let bookMarkLocationList = APIHost.host + "bookmark_location_list.php"; //hsw 20150625 add
    static let userInfo = APIHost.host + "userInfo.php";  //add hsw
    static let loginChk = APIHost.host + "loginChk.php";  //add hsw
    static let postInsert = APIHost.host + "postInsert_ok.php"
    static let myPostList = APIHost.host + "mypost_list.php"
}

struct ImageUrl{
    static let originPath = APIHost.host + "IMAGES/";
    static let thumbPath = APIHost.host + "IMAGES/";
}

