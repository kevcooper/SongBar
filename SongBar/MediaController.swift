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
        
        iTunes = SBApplication(bundleIdentifier:kBundelIdentifiers.iTunes)!
        if let spotify = SBApplication(bundleIdentifier: kBundelIdentifiers.spotify)
        {
            self.Spotify = spotify
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
        let fullTrackText: String = artist != nil ? "\(title) - \(artist!)" : title
        sysBar?.updateStatusBar(itemTitle: <#T##String#>)
    }
    
    func maxLengthString(fullString: String)-> String {
        var charTuncate: Int = 0
        while fullString.size(withAttributes: nil).width > musicWidth {
            charTuncate ++
        }
        //TODO: Remove number of characters from the middle and replace with elipses
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
        }
        return playbackState
    }
    
    func playBackStatus() -> kPlaybackStates {
        guard let lastService: kServices = self.lastServiceUpdated
            else {
                return kPlaybackStates.playing
        }
        switch lastService {
        case kServices.iTunes:
            return self.iTunes?.playerState == iTunesEPlSPlaying ? kPlaybackStates.playing : kPlaybackStates.paused
        case kServices.spotify:
            return self.Spotify?.playerState == SpotifyEPlSPlaying ? kPlaybackStates.playing : kPlaybackStates.paused
        }
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
        }
    }
}

