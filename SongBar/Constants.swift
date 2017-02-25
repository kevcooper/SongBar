//
//  constants.swift
//  SongBar
//
//  Created by Justin Oakes on 2/24/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Foundation

public struct kNotificationNames {
    static let iTunesNotification = "com.apple.iTunes.playerInfo"
    static let spotifyNotification = "com.spotify.client.PlaybackStateChanged"
    static let radiantNotification = "com.sajidanwar.Radiant-Player.PlaybackStateChange"
}

public struct kUserDefaults {
    static let supportiTunes = "supportiTunes"
    static let supportSpotify = "supportSpotify"
    static let supportRadiant = "supportRadiant"
    static let isInitalized = "initalized"
}

public struct kBundelIdentifiers {
    static let iTunes = "com.apple.iTunes"
    static let spotify = "com.spotify.client"
    static let radiant = "com.sajidanwar.Radiant-Player"
}
public enum kServices {
    case iTunes
    case spotify
    case radiant
}
