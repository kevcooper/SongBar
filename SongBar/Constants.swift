//
//  constants.swift
//  SongBar
//
//  Created by Justin Oakes on 2/24/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Foundation

struct kNotificationNames {
    static let iTunesNotification = "com.apple.iTunes.playerInfo"
    static let spotifyNotification = "com.spotify.client.PlaybackStateChanged"
    static let radiantNotification = "com.sajidanwar.Radiant-Player.PlaybackStateChange"
}

struct kUserDefaults {
    static let supportiTunes = "supportiTunes"
    static let supportSpotify = "supportSpotify"
    static let supportRadiant = "supportRadiant"
    static let isInitalized = "initalized"
}

struct kBundelIdentifiers {
    static let iTunes = "com.apple.iTunes"
    static let spotify = "com.spotify.client"
    static let radiant = "com.sajidanwar.Radiant-Player"
}

struct kURLs {
    static let baseURL = "https://itunes.apple.com/search?term="
}

struct kColors {
    static let kBackgroundColor = CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 0.020)
}

struct kMiscStrings {
    static let songbar = "SongBar"
    static let beats = "Beats 1"
}

enum kServices {
    case iTunes
    case spotify
    case radiant
}

enum kPlaybackStates {
    case playing
    case paused
}
