//
//  SettingsWindow.swift
//  SongBar
//
//  Created by Justin Oakes on 2/26/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Cocoa

class SettingsWindow: NSWindowController {

    @IBOutlet weak var view: NSView!
    @IBOutlet weak var iTunesCheckBox: NSButton!
    @IBOutlet weak var spotifyCheckBox: NSButton!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.iTunesCheckBox.state = UserDefaults.standard.integer(forKey: kUserDefaults.supportiTunes)
        self.spotifyCheckBox.state = UserDefaults.standard.integer(forKey: kUserDefaults.supportSpotify)
    }
    
    @IBAction func toggleiTunesSupport(_ sender: Any) {
        UserDefaults.standard.set(self.iTunesCheckBox.state, forKey: kUserDefaults.supportiTunes)
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func toggleSpotifySupport(_ sender: Any) {
        UserDefaults.standard.set(self.spotifyCheckBox.state, forKey: kUserDefaults.supportSpotify)
        UserDefaults.standard.synchronize()
    }
}
