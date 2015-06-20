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
                                                                    selector: "updateiTuensFromNotification:",
                                                                        name: "com.apple.iTunes.playerInfo",
                                                                      object: nil);
        NSDistributedNotificationCenter.defaultCenter().addObserver(self,
                                                                    selector: "updateSpotifyFromNotification:",
                                                                        name: "com.spotify.client.PlaybackStateChanged",
                                                                      object: nil)
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        NSDistributedNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func updateStatusBar(){

        let track: iTunesTrack = iTunes.currentTrack;
        let spotifyTrack: SpotifyTrack = Spotify.currentTrack
        
        let name: String = (track.name != nil) ? track.name : "";
        let artist: String = (track.artist != nil) ? track.artist : "";
        
        let spotifyName: String = spotifyTrack.name != nil ? spotifyTrack.name : ""
        let spotifyArtist: String = spotifyTrack.artist != nil ? spotifyTrack.artist : ""
        
        if(artist != "" && name != ""){
            sysBar.title! = name + " - " + artist;
        }else if spotifyArtist != "" && spotifyName != ""{
            sysBar.title = "\(spotifyName) - \(spotifyArtist)"
        }else{
            sysBar.title! = "SongBar";
        }
        
        
    }
    
    func updateiTuensFromNotification(aNotification: NSNotification){
        let info = aNotification.userInfo! as NSDictionary;
        
        if(info.objectForKey("Name") != nil && info.objectForKey("Artist") != nil){
            let name: String = info.valueForKey("Name") as! String;
            let artist: String = info.valueForKey("Artist")as! String;
            
            sysBar.title! = name + " - " + artist;
        }else{
            sysBar.title! = "SongBar";
        }
    }
    
    func updateSpotifyFromNotification(aNotification: NSNotification){
                let info = aNotification.userInfo! as NSDictionary;
        if info["Name"] != nil && info["Artist"] != nil {
            let name: String = info["Name"] as! String
            let artist: String = info["Artist"] as! String
            
            sysBar.title = "\(name) - \(artist)"
        } else{
            sysBar.title! = "SongBar";
        }
    }
    
    @IBAction func playPause(sender: AnyObject) {
        iTunes.playpause();
    }
    

}

enum Service {
    case iTunes
    
    case spotify
}
