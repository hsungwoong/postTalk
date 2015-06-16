//
//  IGpsManagerDelegate.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 16..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import Foundation

@objc protocol IGpsManagerDelegate {
    // protocol definition goes here
    
     optional func onGpsDidStart();
    optional func onGpsAuthDeny();
}

