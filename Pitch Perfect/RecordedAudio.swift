//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Paul Thaden on 6/4/15.
//  Copyright (c) 2015 Paul Thaden. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(initfilePathURL: NSURL, title: String){
        super.init()
        self.filePathUrl = initfilePathURL
        self.title = title
    
    }
    
}