//
//  AppDelegate.swift
//  SongBar
//
//  Created by Kevin Cooper on 10/21/14.
//  Copyright (c) 2014 corpe. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var menu: NSMenu!
    var mediaController: MediaController = MediaController()
    var sysBar: NSStatusItem!
    
    //magic number
    let variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if UserDefaults.standard.bool(forKey: kUserDefaults.isInitalized) == false {
            UserDefaults.standard.set(true, forKey: kUserDefaults.supportiTunes)
            UserDefaults.standard.set(true, forKey: kUserDefaults.supportSpotify)
            // add suport for radiant here once pull request is accepted
            UserDefaults.standard.set(true, forKey: kUserDefaults.isInitalized)
            UserDefaults.standard.synchronize()
        }
        
        sysBar = NSStatusBar.system().statusItem(withLength: variableStatusItemLength);
        sysBar.menu = menu
        sysBar.updateStatusBar(itemTitle: kMiscStrings.songbar)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        DistributedNotificationCenter.default().removeObserver(self);
    }
    

 

}
