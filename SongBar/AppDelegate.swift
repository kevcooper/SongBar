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
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var menu: NSMenu!
    
    let mediaController: MediaController = MediaController()
    
    var sysBar: NSStatusItem!
    
    
    //magic number
    var variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if UserDefaults.standard.bool(forKey: kUserDefaults.isInitalized) == false {
            UserDefaults.standard.set(true, forKey: kUserDefaults.supportiTunes)
            UserDefaults.standard.set(true, forKey: kUserDefaults.supportSpotify)
            // add suport for radiant here once pull request is accepted
            UserDefaults.standard.set(true, forKey: kUserDefaults.isInitalized)
            UserDefaults.standard.synchronize()
        }
        
        sysBar = NSStatusBar.system().statusItem(withLength: variableStatusItemLength);
        sysBar.menu = menu;
        
        updateStatusBar();
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        DistributedNotificationCenter.default().removeObserver(self);
    }
    
    func updateStatusBar(){

//        let track: iTunesTrack = iTunes.currentTrack
//        var spotifyName: String?
//        var spotifyArtist: String?
//        if let spotifyTrack: SpotifyTrack = Spotify?.currentTrack {
//            spotifyName = spotifyTrack.name != nil ? spotifyTrack.name : ""
//            spotifyArtist = spotifyTrack.artist != nil ? spotifyTrack.artist : ""
//        }
//        
//        let name: String = (track.name != nil) ? track.name : "";
//        let artist: String = (track.artist != nil) ? track.artist : "";
//        
//        
//
//        if  spotifyArtist != nil && spotifyName != nil{
//            sysBar.title = "\(spotifyName!) - \(spotifyArtist!)"
//            self.lastServiceUsed = Service.spotify
//        }else if artist != "" && name != ""{
//            sysBar.title! = name + " - " + artist;
//            self.lastServiceUsed = Service.iTunes
//        }else{
//            sysBar.title! = "SongBar";
//            self.lastServiceUsed = Service.iTunes
//        }
//        
        
    }
    
    
    
    @IBAction func playPause(_ sender: AnyObject) {
//        if lastServiceUsed == Service.iTunes{
//            iTunes.playpause();
//        } else {
//            Spotify!.playpause()
//        }
    }
    
    @IBAction func findInStore(_ sender: AnyObject) {
        let searchString: NSString = sysBar.title! as NSString
        StoreSearch.search(searchString)
    }
 

}
