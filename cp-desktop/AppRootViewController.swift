//
//  AppViewController.swift
//  cp-desktop
//
//  Created by Adrian Vatchinsky on 1/7/16.
//  Copyright © 2016 Adrian Vatchinsky. All rights reserved.
//

import Cocoa
import AppKit

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
        
        let nib = NSNib(nibNamed: "SnippetCellView", bundle: NSBundle.mainBundle())
        snippetTableView.registerNib(nib!, forIdentifier: "SnippetCellView")
        
        
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
        
        let cell = tableView.makeViewWithIdentifier("SnippetCellView", owner: self) as! SnippetCellView

        
        if tableColumn!.identifier == "SnippetColumn" {

            let snippet = self.snippets[row]
            cell.snippetTextContent.stringValue = snippet.content

            return cell
        }
        return cell
    }
}


// MARK: - NSTableViewDelegate
extension AppRootViewController: NSTableViewDelegate {
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        print("Calculating the row of the thing")
        let coef = 2.5
        
        let snippet = self.snippets[row]
        let cell = tableView.makeViewWithIdentifier("SnippetCellView", owner: self) as! SnippetCellView

        cell.snippetTextContent.stringValue = snippet.content
        cell.snippetMultiLineLabel.sizeToFit()
        
        return cell.snippetMultiLineLabel.frame.height * CGFloat(coef)
    }
}


extension String {
    var length: Int {
        return characters.count
    }
}
