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
    @IBOutlet weak var menu: NSMenu!
    
    var sysBar: NSStatusItem!
    var iTunes: AnyObject!
    var Spotify: AnyObject!
    //magic number
    var variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        sysBar = NSStatusBar.systemStatusBar().statusItemWithLength(variableStatusItemLength);
        sysBar.menu = menu;
        iTunes = SBApplication.applicationWithBundleIdentifier("com.apple.iTunes");
        Spotify = SBApplication.applicationWithBundleIdentifier("com.spotify.client")
        
        updateStatusBar();
        
        NSDistributedNotificationCenter.defaultCenter().addObserver(self,
            selector: "updateFromNotification:",
            name: "com.apple.iTunes.playerInfo",
            object: nil);
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        NSDistributedNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func updateStatusBar(){
        
        let iTtrack: iTunesTrack = iTunes.currentTrack;
        let iTname: String = (iTtrack.name != nil) ? iTtrack.name : "";
        let iTartist: String = (iTtrack.artist != nil) ? iTtrack.artist : "";
        
        let sTrack: SpotifyTrack = Spotify.currentTrack;
        let sName: String = (sTrack.name != nil) ? sTrack.name : "";
        let sArtist: String = (sTrack.name != nil) ? sTrack.artist : "";
        
        if(iTartist == "" && iTname == "" && sArtist == "" && sName == ""){
            sysBar.title! = "SongBar";
        }else if (sTrack != "" && sName != ""){
            sysBar.title! = sName + " by " + sArtist;
            
        }else {
            sysBar.title! = iTname + " by " + iTartist
        }
        
        
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
    
    @IBAction func playPause(sender: AnyObject) {
        iTunes.playpause();
    }
    
    
}
