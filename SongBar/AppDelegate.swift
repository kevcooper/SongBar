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

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    
    var sysBar: NSStatusItem!
    var iTunes: AnyObject!
    
    //magic number
    var variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        sysBar = NSStatusBar.systemStatusBar().statusItemWithLength(100);
        iTunes = SBApplication.applicationWithBundleIdentifier("com.apple.iTunes");
        
        updateStatusBar();
        
        NSDistributedNotificationCenter.defaultCenter().addObserver(self,
            selector: "updateStatusBar",
            name: "com.apple.iTunes.playerInfo",
            object: nil);
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        NSDistributedNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func updateStatusBar(){
        let track: iTunesTrack = iTunes.currentTrack;
        
        let name: String = (track.name != nil) ? track.name : "";
        let artist: String = (track.artist != nil) ? track.artist : "";
        
        if(artist != "" && name != ""){
            sysBar.title! = name + " by " + artist;
        }else{
            sysBar.title! = "SongBar";
        }
        
        
    }
    
    
}
