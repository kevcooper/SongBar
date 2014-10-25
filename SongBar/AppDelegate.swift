//
//  AppDelegate.swift
//  SongBar
//
//  Created by Kevin Cooper on 10/21/14.
//  Copyright (c) 2014 corpe. All rights reserved.
//

import Cocoa
import AppKit
import ScriptingBridge
import Foundation


@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var menu: NSMenu!
    @IBOutlet weak var updater: SUUpdater!
    @IBOutlet weak var iTunes: iTunesBridge!
    var sysBar: NSStatusItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        updater.checkForUpdatesInBackground();
        sysBar = NSStatusBar.systemStatusBar().statusItemWithLength(200);
        sysBar.menu = menu;
        
        NSDistributedNotificationCenter.defaultCenter().addObserver(self,
            selector: "updateFromNotification:",
            name: "com.apple.iTunes.playerInfo",
            object: nil);
        
        iTunes.postNotificationForCurrentTrack();
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        NSDistributedNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func updateFromNotification(aNotification: NSNotification){
        let info = aNotification.userInfo! as NSDictionary;
        
        if(info.objectForKey("Name") != nil && info.objectForKey("Artist") != nil){
            let name: String = info.valueForKey("Name") as String;
            let artist: String = info.valueForKey("Artist") as String;
            
            sysBar.title! = name + " - " + artist;
        }else{
            sysBar.title! = "SongBar";
        }
    }
}
