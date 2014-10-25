//
//  iTunesBridge.swift
//  SongBar
//
//  Created by Kevin Cooper on 10/25/14.
//  Copyright (c) 2014 corpe. All rights reserved.
//

import Cocoa

class iTunesBridge: NSObject {
    private var iTunes: AnyObject!
    
    
    override init(){
        iTunes = SBApplication.applicationWithBundleIdentifier("com.apple.iTunes");
    }
    
    @IBAction func playPause(sender: AnyObject) {
        iTunes.playpause();
    }
    
    @IBAction func nextTrack(sender: AnyObject) {
        iTunes.nextTrack();
    }
    
    @IBAction func previousTrack(sender: AnyObject) {
        iTunes.previousTrack();
    }
    
    func postNotificationForCurrentTrack(){
        var track:iTunesTrack = iTunes.currentTrack;
        
        var info:NSMutableDictionary = NSMutableDictionary();
        
        info.setValue(track.artist, forKey: "Artist");
        info.setValue(track.name, forKey: "Name");
        
        NSDistributedNotificationCenter.defaultCenter().postNotificationName("com.apple.iTunes.playerInfo", object: nil, userInfo: info);
    }

}
