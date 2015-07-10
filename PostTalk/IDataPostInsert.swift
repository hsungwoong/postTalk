//
//  IDataPostInsert.swift
//  PostTalk
//
//  Created by dykim on 2015. 7. 9..
//  Copyright (c) 2015년 cstone dev. All rights reserved.
//

import Foundation

protocol IDataPostInsert {
    // protocol definition goes here
    
    func onPostInsertStart();
    func onPostInsertComplete();
    func onPostInsertFail();
}