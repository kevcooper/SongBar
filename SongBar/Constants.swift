//
//  constants.swift
//  SongBar
//
//  Created by Justin Oakes on 2/24/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Foundation

//App IDs
let iTunesNotification = "com.apple.iTunes.playerInfo"
let spotifyNotification = "com.spotify.client.PlaybackStateChanged"

//Default Keys
struct kUserDefaults {
    static let supportiTunes = "supportiTunes"
    static let supportSpotify = "supportSpotify"
    static let isInitalized = "initalized"
}

//Bundel IDs
let iTunes = "com.apple.iTunes"
let spotify = "com.spotify.client"

//URL strings
let baseURL = "https://itunes.apple.com/search?term="


//Storyboard names
let musicView = "MusicView"
let mainMenu = "MainMenu"
let settingsWindow = "SettingsWindow"

//Colors
let kBackgroundColor = CGColor(red: 0.965, green: 0.965, blue: 0.965, alpha: 0.020)

//Mesurements
let musicWidth: CGFloat = 320.0
let musicHeight: CGFloat = 96.0

//Misc
let songbar = "SongBar"
let beats = "Beats 1"

enum kServices {
    case iTunes
    case spotify
}

enum kPlaybackStates {
    case playing
    case paused
}
