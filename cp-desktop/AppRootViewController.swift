//
//  AppViewController.swift
//  cp-desktop
//
//  Created by Adrian Vatchinsky on 1/7/16.
//  Copyright © 2016 Adrian Vatchinsky. All rights reserved.
//

import Cocoa

class AppRootViewController: NSViewController {
    
    @IBOutlet var textView: NSTextView!
    
    private let notificationCenter = NSNotificationCenter.defaultCenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.view.setFrameSize(NSSize(width: 350, height: 500))
        
        let watcher = PasteboardWatcher(fileKinds: ["String"])
        watcher.startPolling()
        
        self.notificationCenter.addObserver(self, selector: "updateCurrentClipboardItem:", name: "clipboardUpdatedNotification", object: nil)
        
    }
    
    func updateCurrentClipboardItem(notification: NSNotification){
        print("NOTIFIED")
        print(notification.userInfo!["snippet"])
        self.textView.string = notification.userInfo!["snippet"] as? String
    }
    
}
