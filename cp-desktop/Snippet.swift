//
//  Snippet.swift
//  cp-desktop
//
//  Created by Adrian Vatchinsky on 1/8/16.
//  Copyright © 2016 Adrian Vatchinsky. All rights reserved.
//

import Cocoa

class Snippet: NSObject {
    var content: String
    
    override init(){
        self.content = String()
    }
    
    init(content: String){
        self.content = content
    }
}
