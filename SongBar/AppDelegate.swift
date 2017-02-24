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
    
    var lastServiceUsed: Service?
    
    var sysBar: NSStatusItem!
    var iTunes: AnyObject!
    var Spotify: AnyObject?
    
    //magic number
    var variableStatusItemLength: CGFloat = -1;
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        sysBar = NSStatusBar.system().statusItem(withLength: variableStatusItemLength);
        sysBar.menu = menu;
        iTunes = SBApplication(bundleIdentifier:"com.apple.iTunes")!
        if let spotify = SBApplication(bundleIdentifier: "com.spotify.client")
        {
            self.Spotify = spotify
        }
        
        updateStatusBar();
        
        DistributedNotificationCenter.default().addObserver(self,
                                                                    selector: #selector(self.updateiTuensFromNotification(_:)),
                                                                        name: NSNotification.Name(rawValue: "com.apple.iTunes.playerInfo"),
                                                                      object: nil)
        DistributedNotificationCenter.default().addObserver(self,
                                                                    selector: #selector(self.updateSpotifyFromNotification(_:)),
                                                                    name: NSNotification.Name(rawValue:"com.spotify.client.PlaybackStateChanged"),
                                                                      object: nil)
        
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        DistributedNotificationCenter.default().removeObserver(self);
    }
    
    func updateStatusBar(){

        let track: iTunesTrack = iTunes.currentTrack
        var spotifyName: String?
        var spotifyArtist: String?
        if let spotifyTrack: SpotifyTrack = Spotify?.currentTrack {
            spotifyName = spotifyTrack.name != nil ? spotifyTrack.name : ""
            spotifyArtist = spotifyTrack.artist != nil ? spotifyTrack.artist : ""
        }
        
        let name: String = (track.name != nil) ? track.name : "";
        let artist: String = (track.artist != nil) ? track.artist : "";
        
        

        if  spotifyArtist != nil && spotifyName != nil{
            sysBar.title = "\(spotifyName!) - \(spotifyArtist!)"
            self.lastServiceUsed = Service.spotify
        }else if artist != "" && name != ""{
            sysBar.title! = name + " - " + artist;
            self.lastServiceUsed = Service.iTunes
        }else{
            sysBar.title! = "SongBar";
            self.lastServiceUsed = Service.iTunes
        }
        
        
    }
    
    func updateiTuensFromNotification(_ aNotification: Notification){
        let info = aNotification.userInfo! as NSDictionary;
        
        if(info.object(forKey: "Name") != nil && info.object(forKey: "Artist") != nil){
            let name: String = info.value(forKey: "Name") as! String;
            let artist: String = info.value(forKey: "Artist")as! String;
            
            sysBar.title! = name + " - " + artist;
            lastServiceUsed = Service.iTunes
        }else if (info.object(forKey: "Name") != nil && info.object(forKey: "Artist") == nil) {
            let name: String = info.value(forKey: "Name") as! String;
            sysBar.title = "\(name)"
        }
        
        else{
            sysBar.title! = "SongBar";
        }
    }
    
    func updateSpotifyFromNotification(_ aNotification: Notification){
                let info = aNotification.userInfo! as NSDictionary;
        if info["Name"] != nil && info["Artist"] != nil {
            let name: String = info["Name"] as! String
            let artist: String = info["Artist"] as! String
            
            sysBar.title = "\(name) - \(artist)"
            
            lastServiceUsed = Service.spotify
        } else{
            sysBar.title! = "SongBar";
        }
    }
    
    @IBAction func playPause(_ sender: AnyObject) {
        if lastServiceUsed == Service.iTunes{
            iTunes.playpause();
        } else {
            Spotify!.playpause()
        }
    }
    
    @IBAction func findInStore(_ sender: AnyObject) {
        let searchString: NSString = sysBar.title! as NSString
        StoreSearch.search(searchString)
    }
 

}

enum Service {
    case iTunes
    
    case spotify
}
