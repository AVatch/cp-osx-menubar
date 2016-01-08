//
//  PasteBoardWatcher.swift
//  cp-desktop
//
//  Created by Adrian Vatchinsky on 1/7/16.
//  Copyright © 2016 Adrian Vatchinsky. All rights reserved.
//

import Cocoa

protocol PasteboardWatcherDelegate {
    
    func newlyCopiedStringObtained(copiedString copiedString : NSString)
}

class PasteboardWatcher : NSObject {
    
    private let pasteboard = NSPasteboard.generalPasteboard()
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    private var changeCount : Int
    private var latestSnippet: String {
        didSet{
//            self.notificationCenter.postNotification(NSNotification(name: "clipboardUpdatedNotification", object: latestSnippet))
            self.notificationCenter.postNotificationName("clipboardUpdatedNotification", object: nil, userInfo: ["snippet": latestSnippet])
        }
    }

    private var timer: NSTimer?
    
    var delegate: PasteboardWatcherDelegate?
    
    var snippets: [String]
    
    private let fileKinds: [String]
    
    init(fileKinds: [String]){
        changeCount = pasteboard.changeCount
        self.fileKinds = fileKinds
        self.latestSnippet = ""
        self.snippets = []
        
        super.init()
    }
    
    // starts polling to identify if url with desired kind is copied
    func startPolling(){
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("checkForChangesInPasteboard"), userInfo: nil, repeats: true)
    }
    
    // method invoked continuously by timer
    @objc private func checkForChangesInPasteboard(){
        // check if there is any new item copied
        // also check if kind of copied item is string
        if let copiedString = pasteboard.stringForType(NSPasteboardTypeString) where pasteboard.changeCount != changeCount {
            
            // obtain string from copied link if its path extension is one of desired extensions
            self.delegate?.newlyCopiedStringObtained(copiedString: copiedString)
            
            self.snippets.append(copiedString)
            self.latestSnippet = copiedString
            
            // assign new change count to instance variable for later comparison
            changeCount = pasteboard.changeCount
            
        }
    }
}

