//
//  AppDelegate.swift
//  cp-desktop
//
//  Created by Adrian Vatchinsky on 1/7/16.
//  Copyright © 2016 Adrian Vatchinsky. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSSquareStatusItemLength)
    let popover = NSPopover()

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: "copypasta")
            button.action = Selector("togglePopover:")
        }
        
        popover.contentViewController = AppRootViewController(nibName: "AppRootViewController", bundle: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    
    
    
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            self.popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        self.popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?) {
        if self.popover.shown {
            closePopover(sender)
        }else{
            showPopover(sender)
        }
    }

}

