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
    
<<<<<<< HEAD
    //magic number
    let variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if UserDefaults.standard.bool(forKey: kUserDefaults.isInitalized) == false {
            UserDefaults.standard.set(true, forKey: kUserDefaults.supportiTunes)
            UserDefaults.standard.set(true, forKey: kUserDefaults.supportSpotify)
            // add suport for radiant here once pull request is accepted
            UserDefaults.standard.set(true, forKey: kUserDefaults.isInitalized)
            UserDefaults.standard.synchronize()
=======
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        
        sysBar = NSStatusBar.systemStatusBar().statusItemWithLength(variableStatusItemLength);
        sysBar.menu = menu;
        iTunes = SBApplication(bundleIdentifier: "com.apple.iTunes")
        Spotify = SBApplication(bundleIdentifier: "com.spotify.client")
        
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
>>>>>>> a691bea6460ee0055c4cc9af2699d8b0a564015b
        }
        
        sysBar = NSStatusBar.system().statusItem(withLength: variableStatusItemLength);
        sysBar.menu = menu
        sysBar.updateStatusBar(itemTitle: kMiscStrings.songbar)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        DistributedNotificationCenter.default().removeObserver(self);
    }
    

 

}
