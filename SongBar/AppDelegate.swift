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
    let mediaController: MediaController = MediaController()
    let listener: PlayerNotificationCenterListener = PlayerNotificationCenterListener()
    var sysBar: NSStatusItem!
    
    //magic number
    let variableStatusItemLength: CGFloat = -1
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        sysBar = NSStatusBar.system.statusItem(withLength: variableStatusItemLength);
        sysBar.updateStatusBar(itemTitle: mediaController.playingServiceTitle())
        sysBar.menu = menu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        DistributedNotificationCenter.default().removeObserver(self);
    }
    

 

}
