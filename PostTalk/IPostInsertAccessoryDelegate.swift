//
//  IPostInsertAccessoryDelegate.swift
//  PostTalk
//
//  Created by dykim on 2015. 6. 23..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import Foundation

protocol IPostInsertAccessoryDelegate{
    func sendPost(target:AnyObject);
    func selectAlbum(target:AnyObject);
    func openCamera(target:AnyObject);
}
