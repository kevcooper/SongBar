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
        
        iTunes = SBApplication(bundleIdentifier:"com.apple.iTunes")!
        if let spotify = SBApplication(bundleIdentifier: "com.spotify.client")
        {
            self.Spotify = spotify
        }
        if let radiant = SBApplication(bundleIdentifier: "com.sajidanwar.Radiant-Player") {
            self.Radiant = radiant
        }
    }
    
    func updateTitleFromNotification(_ aNotification: Notification) -> String {
        let sender: String = aNotification.name.rawValue
        let userInfo: [String : AnyObject] = aNotification.userInfo as! [String : AnyObject]
        
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
                  return "SongBar"
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
            return "\(title) - \(artist)"
        } else {
            return title
        }
    }

}

