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
    
    override init() {
        super.init()
    }
        
        class func installedPlayers() -> [kServices] {
            var installedPlayers: [kServices] = []
            if let _ = LSCopyApplicationURLsForBundleIdentifier(kBundelIdentifiers.iTunes as CFString, nil) {
                installedPlayers.append(.iTunes)
            }
            if let _ = LSCopyApplicationURLsForBundleIdentifier(kBundelIdentifiers.spotify as CFString, nil) {
                installedPlayers.append(.spotify)
            }
            return installedPlayers
        }
        
    class func runningPlayers() -> [Player] {
            let runningApps: [NSRunningApplication] = NSWorkspace.shared.runningApplications
        var runningPlayers: [Player] = [Player]()
            
            if runningApps.contains(where: { (application) -> Bool in
                application.bundleIdentifier == kBundelIdentifiers.iTunes
            }) {
                if let itunes: SBApplication = SBApplication(bundleIdentifier: kBundelIdentifiers.iTunes) {
                    runningPlayers.append(Player(application: .iTunes,
                                                 bridgedApplication: itunes))
                }
                
            }
            if runningApps.contains(where: { (application) -> Bool in
                application.bundleIdentifier == kBundelIdentifiers.spotify
            }) {
                if let spotify: SBApplication = SBApplication(bundleIdentifier: kBundelIdentifiers.spotify) {
                    runningPlayers.append(Player(application: .spotify,
                                                 bridgedApplication: spotify))
                }
            }
            return runningPlayers
        }
    
    class func playingService() -> Player {
        let services: [Player] = runningPlayers()
        // Determaning what app to take control of
        
        // is there only one application running?
        if services.count == 1 {
            return services[0]
        } else {
            let iTunes = services.first(where: { (player) -> Bool in
                player.application == kServices.iTunes
            })
            let Spotify = services.first(where: { (player) -> Bool in
                player.application == kServices.spotify
            })
            var playingservices: [Player] = []
            if (iTunes?.bridgedApplication as AnyObject).playerState == iTunesEPlSPlaying {
                playingservices.append(iTunes!)
            }
            if (Spotify?.bridgedApplication as AnyObject).playerState == SpotifyEPlSPlaying {
                playingservices.append(Spotify!)
            }
            if playingservices.count == 1 {
                return playingservices[0]
            }
        }
        
        // Default to first player
        return services[0]
    }
    
//        iTunes = SBApplication(bundleIdentifier:kBundelIdentifiers.iTunes)!
//        if let spotify = SBApplication(bundleIdentifier: kBundelIdentifiers.spotify)
//        {
//            self.Spotify = spotify
//        }
    }
    
//    @objc func updateTitleFromNotification(_ aNotification: Notification) {
//        let sender: String = aNotification.name.rawValue
//        let userInfo: [String : AnyObject] = aNotification.userInfo as! [String : AnyObject]
//        let sysBar = (NSApplication.shared.delegate as! AppDelegate).sysBar
//        
//        switch sender {
//        case kNotificationNames.iTunesNotification:
//            self.lastServiceUpdated = kServices.iTunes
//            if self.iTunes == nil {
//                self.iTunes = SBApplication(bundleIdentifier: kBundelIdentifiers.iTunes)
//            }
//            break
//        case kNotificationNames.spotifyNotification:
//            self.lastServiceUpdated = kServices.spotify
//            if self.Spotify == nil {
//                self.Spotify = SBApplication(bundleIdentifier: kBundelIdentifiers.spotify)
//            }
//            break
//        default:
//            break
//        }
//        
//        let title: String
//        let artist: String?
//        if let _: String = userInfo["Name"] as? String {
//            title = userInfo["Name"] as! String
//        } else {
//            if let _: String = userInfo["title"] as? String {
//                title = userInfo["title"] as! String
//            } else {
//                  sysBar?.updateStatusBar(itemTitle: kMiscStrings.songbar)
//                return
//                }
//            }
//        
//        if let _: String = userInfo["Artist"] as? String {
//            artist = userInfo["Artist"] as? String
//        } else {
//            if let _: String = userInfo["artist"] as? String {
//                artist = userInfo["artist"] as? String
//            } else {
//                  artist = nil
//              }
//            }
//        let fullTrackText: String = artist != nil ? "\(title) - \(artist!)" : title
//        sysBar?.updateStatusBar(itemTitle: maxLengthString(fullString: fullTrackText))
//    }
//    
//
//    func maxLengthString(fullString: String)-> String {
//        let middleCharIndex = fullString.index(fullString.startIndex, offsetBy: fullString.characters.count / 2)
//        var firstHalf: String = fullString.substring(to: middleCharIndex)
//        var lastHalf: String = fullString.substring(from: middleCharIndex)
//        
//        while stringWidthWithFont(string: "\(firstHalf)\(lastHalf)" as NSString, font: nil)  > musicWidth {
//            firstHalf.characters = firstHalf.characters.dropLast(1)
//            lastHalf.characters = lastHalf.characters.dropFirst(1)
//        }
//
//        return fullString == "\(firstHalf)\(lastHalf)" ? fullString : "\(firstHalf)...\(lastHalf)" 
//        
//    }
//    
//    func stringWidthWithFont(string: NSString, font: NSFont?)-> CGFloat {
//        let boundingSize: NSSize = NSSize(width: .greatestFiniteMagnitude, height: musicHeight)
//        let labelSize: NSRect = string.boundingRect(with: boundingSize,
//                                                    options: NSString.DrawingOptions.usesLineFragmentOrigin,
//                                                    attributes: [NSAttributedStringKey.font : font ?? NSFont.systemFont(ofSize: 14)])
//        return labelSize.width
//    }
//    
//    func playPauseLastService() -> kPlaybackStates {
//        var playbackState: kPlaybackStates
//        guard let lastService: kServices = self.lastServiceUpdated
//            else {
//                return kPlaybackStates.paused
//        }
//        
//        switch lastService {
//        case kServices.iTunes:
//            if self.iTunes?.playerState == iTunesEPlSPlaying{
//                playbackState = kPlaybackStates.paused
//            } else {
//                playbackState = kPlaybackStates.playing
//            }
//            self.iTunes?.playpause()
//            break
//        case kServices.spotify:
//            if self.Spotify?.playerState == SpotifyEPlSPlaying {
//                playbackState = kPlaybackStates.paused
//            } else {
//                playbackState = kPlaybackStates.playing
//            }
//            self.Spotify?.playpause()
//            break
//        }
//        return playbackState
//    }
//    
//    func playBackStatus() -> kPlaybackStates {
//        guard let lastService: kServices = self.lastServiceUpdated
//            else {
//                return kPlaybackStates.playing
//        }
//        switch lastService {
//        case kServices.iTunes:
//            return self.iTunes?.playerState == iTunesEPlSPlaying ? kPlaybackStates.playing : kPlaybackStates.paused
//        case kServices.spotify:
//            return self.Spotify?.playerState == SpotifyEPlSPlaying ? kPlaybackStates.playing : kPlaybackStates.paused
//        }
//    }
//    
//    func fastForwardLastService() {
//        guard let lastService: kServices = self.lastServiceUpdated
//            else{
//                return
//        }
//        switch lastService {
//        case kServices.iTunes:
//            self.iTunes?.nextTrack()
//            break
//        case kServices.spotify:
//            self.Spotify?.nextTrack()
//            break
//        }
//    }
//
//    func rewindLastService() {
//        guard let lastService: kServices = self.lastServiceUpdated
//            else{
//                return
//        }
//        switch lastService {
//        case kServices.iTunes:
//            self.iTunes?.previousTrack()
//            break
//        case kServices.spotify:
//            self.Spotify?.previousTrack()
//            break
//        }
//    }

