//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Qazi on 04/06/2015.
//  Copyright (c) 2015 Qazi. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePath: NSURL, title: String) {
        self.title   = title
        self.filePathUrl = filePath

    }
}