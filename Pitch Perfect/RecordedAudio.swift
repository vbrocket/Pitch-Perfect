//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Ibrahim.Moustafa on 1/9/16.
//  Copyright (c) 2016 Ibrahim.Moustafa. All rights reserved.
//

import Foundation

class RecordedAudio{
    var filePathUrl: NSURL!
    var title: String!
    
    init(){}
    init(filePathUrl:NSURL,title: String){
        self.filePathUrl=filePathUrl
        self.title = title
    }
    
}