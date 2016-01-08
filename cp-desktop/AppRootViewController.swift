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
    
    @IBOutlet weak var snippetTableView: NSTableView!
    
    
    var snippets = [Snippet]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        initSnippets()
        
        self.view.setFrameSize(NSSize(width: 350, height: 500))
        
        let watcher = PasteboardWatcher(fileKinds: ["String"])
        watcher.startPolling()
        
        self.notificationCenter.addObserver(self, selector: "updateCurrentClipboardItem:", name: "clipboardUpdatedNotification", object: nil)
        
    }
    
    func updateCurrentClipboardItem(notification: NSNotification){
        self.textView.string = notification.userInfo!["snippet"] as? String
        
        let snippet = Snippet(content: notification.userInfo!["snippet"] as! String)
        self.snippets.insert(snippet, atIndex: 0)
        self.snippetTableView.insertRowsAtIndexes(NSIndexSet(index: 0), withAnimation: NSTableViewAnimationOptions.EffectGap)
    }
    
    
    func initSnippets(){
        // TODO
    }
    
}

// MARK: - NSTableViewDataSource
extension AppRootViewController: NSTableViewDataSource {
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return self.snippets.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
    
        if tableColumn!.identifier == "SnippetColumn" {
            // 3
            let snippet = self.snippets[row]
            cellView.textField!.stringValue = snippet.content

            return cellView
        }
        
        return cellView
    }
}

// MARK: - NSTableViewDelegate
extension AppRootViewController: NSTableViewDelegate {
}
