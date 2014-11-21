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
    @IBOutlet weak var iTunesOutlet: NSMenuItem!
    @IBOutlet weak var spotifyOutlet: NSMenuItem!
    
    var sysBar: NSStatusItem!
    var iTunes: AnyObject!
    var Spotify: AnyObject!
    var MusicApp: String? = nil
    var timer: NSTimer?
    
    //magic number
    var variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        sysBar = NSStatusBar.systemStatusBar().statusItemWithLength(variableStatusItemLength);
        sysBar.menu = menu;
        iTunes = SBApplication.applicationWithBundleIdentifier("com.apple.iTunes");
        Spotify = SBApplication.applicationWithBundleIdentifier("com.spotify.client")
        
        MusicApp = NSUserDefaults.standardUserDefaults().valueForKey("MusicApp")?.string
        
        if MusicApp == "Spotify" {
            iTunesOutlet.title = "iTunes"
            spotifyOutlet.title = "Spotify √"
            MusicApp = "Spotify"
        } else {
            iTunesOutlet.title = "iTunes √"
            spotifyOutlet.title = "Spotify"
            timer?.invalidate()
            MusicApp = "iTunes"
            
        }
        
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
    
        if MusicApp == nil {
            MusicApp =  "iTunes"
        }
        switch MusicApp! {
            case "iTunes":
                let track: iTunesTrack = iTunes.currentTrack;
                let name: String = (track.name != nil) ? track.name : "";
                let artist: String = (track.artist != nil) ? track.artist : "";
            
                
                if(artist == "" && name == ""){
                    sysBar.title! = "SongBar";
                } else {
                    sysBar.title! = name + " by " + artist
                    
            }
            
            case "Spotify":
                updateSpotify()
                
                let track: SpotifyTrack = Spotify.currentTrack;
                let name: String = (track.name != nil) ? track.name : "";
                let artist: String = (track.name != nil) ? track.artist : "";
            
                if(artist == "" && name == ""){
                    sysBar.title! = "SongBar";
                } else {
                    sysBar.title! = name + " by " + artist
            }
            default:
                let track: iTunesTrack = iTunes.currentTrack;
                let name: String = (track.name != nil) ? track.name : "";
                let artist: String = (track.artist != nil) ? track.artist : "";
            
                if(artist == "" && name == ""){
                    sysBar.title! = "SongBar";
                } else {
                    sysBar.title! = name + " by " + artist
                }
        
            }
    }
    
    func updateSpotify() {
        if timer == nil{
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "updateStatusBar", userInfo: nil, repeats: true)
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
        if MusicApp != nil {
            switch MusicApp!{
            case "iTunes":
                iTunes.playpause();
            case "Spotify":
                Spotify.playpause()
            default:
                iTunes.playpause()
            }
        }
    }
   
    @IBAction func switchiTunes(sender: AnyObject) {
        iTunesOutlet.title = "iTunes √"
        spotifyOutlet.title = "Spotify"
        timer?.invalidate()
        MusicApp = "iTunes"
        NSUserDefaults.standardUserDefaults().setValue("iTunes", forKey: "MusicApp")
    }
    
    @IBAction func switchSpotify(sender: AnyObject) {
        iTunesOutlet.title = "iTunes"
        spotifyOutlet.title = "Spotify √"
        MusicApp = "Spotify"
        NSUserDefaults.standardUserDefaults().setValue("Spotify", forKey: "MusicApp")
        updateStatusBar()
    }
    
}

