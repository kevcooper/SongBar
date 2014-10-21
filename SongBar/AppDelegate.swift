//
//  AppDelegate.swift
//  SongBar
//
//  Created by Kevin Cooper on 10/21/14.
//  Copyright (c) 2014 corpe. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    var sysBar: NSStatusItem!
    var variableStatusItemLength: CGFloat = -1;

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        sysBar = NSStatusBar.systemStatusBar().statusItemWithLength(variableStatusItemLength);
        sysBar.title = "hello";

        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}
