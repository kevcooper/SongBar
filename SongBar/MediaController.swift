//
//  MediaController.swift
//  SongBar
//
//  Created by Justin Oakes on 2/23/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Cocoa
import ScriptingBridge

class MediaController: NSObject {
    var iTunes: AnyObject?
    var Spotify: AnyObject?
    var Radiant: AnyObject?
    
    var lastServiceUpdated: kServices?
    
    override init() {
        super.init()
        if UserDefaults.standard.bool(forKey: kUserDefaults.supportiTunes) {
            DistributedNotificationCenter.default().addObserver(self,
                                                                selector: #selector(self.updateTitleFromNotification(_:)),
                                                                name: NSNotification.Name(rawValue: kNotificationNames.iTunesNotification),
                                                                object: nil)
        }
        if UserDefaults.standard.bool(forKey: kUserDefaults.supportSpotify) {
            DistributedNotificationCenter.default().addObserver(self,
                                                                selector: #selector(self.updateTitleFromNotification(_:)),
                                                                name: NSNotification.Name(rawValue: kNotificationNames.spotifyNotification),
                                                                object: nil)
        }
        if UserDefaults.standard.bool(forKey: kUserDefaults.supportRadiant) {
            DistributedNotificationCenter.default().addObserver(self,
                                                                selector: #selector(self.updateTitleFromNotification(_:)),
                                                                name: NSNotification.Name(rawValue: kNotificationNames.radiantNotification),
                                                                object: nil)
        }
        
        iTunes = SBApplication(bundleIdentifier:kBundelIdentifiers.iTunes)!
        if let spotify = SBApplication(bundleIdentifier: kBundelIdentifiers.spotify)
        {
            self.Spotify = spotify
        }
        if let radiant = SBApplication(bundleIdentifier: kBundelIdentifiers.radiant) {
            self.Radiant = radiant
        }
    }
    
    func updateTitleFromNotification(_ aNotification: Notification) {
        let sender: String = aNotification.name.rawValue
        let userInfo: [String : AnyObject] = aNotification.userInfo as! [String : AnyObject]
        let sysBar = (NSApplication.shared().delegate as! AppDelegate).sysBar
        
        switch sender {
        case kNotificationNames.iTunesNotification:
            self.lastServiceUpdated = kServices.iTunes
            if self.iTunes == nil {
                self.iTunes = SBApplication(bundleIdentifier: kBundelIdentifiers.iTunes)
            }
            break
        case kNotificationNames.spotifyNotification:
            self.lastServiceUpdated = kServices.spotify
            if self.Spotify == nil {
                self.Spotify = SBApplication(bundleIdentifier: kBundelIdentifiers.spotify)
            }
            break
        case kNotificationNames.radiantNotification:
            self.lastServiceUpdated = kServices.radiant
            if self.Radiant == nil {
                self.Radiant = SBApplication(bundleIdentifier: kBundelIdentifiers.radiant)
            }
            break
        default:
            break
        }
        
        let title: String
        let artist: String?
        if let _: String = userInfo["Name"] as? String {
            title = userInfo["Name"] as! String
        } else {
            if let _: String = userInfo["title"] as? String {
                title = userInfo["title"] as! String
            } else {
                  sysBar?.updateStatusBar(itemTitle: kMiscStrings.songbar)
                return
                }
            }
        
        if let _: String = userInfo["Artist"] as? String {
            artist = userInfo["Artist"] as? String
        } else {
            if let _: String = userInfo["artist"] as? String {
                artist = userInfo["artist"] as? String
            } else {
                  artist = nil
              }
            }
        
        if artist != nil {
            sysBar?.updateStatusBar(itemTitle: "\(title) - \(artist!)")
        } else {
            sysBar?.updateStatusBar(itemTitle: title)
        }
    }
    
    func playPauseLastService() -> kPlaybackStates {
        var playbackState: kPlaybackStates
        guard let lastService: kServices = self.lastServiceUpdated
            else {
                return kPlaybackStates.paused
        }
        
        switch lastService {
        case kServices.iTunes:
            if self.iTunes?.playerState == iTunesEPlSPlaying{
                playbackState = kPlaybackStates.paused
            } else {
                playbackState = kPlaybackStates.playing
            }
            self.iTunes?.playpause()
            break
        case kServices.spotify:
            if self.Spotify?.playerState == SpotifyEPlSPlaying {
                playbackState = kPlaybackStates.paused
            } else {
                playbackState = kPlaybackStates.playing
            }
            self.Spotify?.playpause()
            break
        case kServices.radiant:
            if self.Radiant?.playerState == 2 {
                playbackState = kPlaybackStates.paused
            } else {
                playbackState = kPlaybackStates.playing
            }
            self.Radiant?.playpause()
            break
        }
        return playbackState
    }
    
    func fastForwardLastService() {
        guard let lastService: kServices = self.lastServiceUpdated
            else{
                return
        }
        switch lastService {
        case kServices.iTunes:
            self.iTunes?.nextTrack()
            break
        case kServices.spotify:
            self.Spotify?.nextTrack()
            break
        case kServices.radiant:
            self.Radiant?.nextTrack()
            break
        }
    }

    func rewindLastService() {
        guard let lastService: kServices = self.lastServiceUpdated
            else{
                return
        }
        switch lastService {
        case kServices.iTunes:
            self.iTunes?.previousTrack()
            break
        case kServices.spotify:
            self.Spotify?.previousTrack()
            break
        case kServices.radiant:
            self.Radiant?.previousTrack()
            break
        }
    }
}

