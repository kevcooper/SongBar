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
    }
    
    @IBAction func toggleiTunesSupport(_ sender: Any) {
    
    }
    
    @IBAction func toggleSpotifySupport(_ sender: Any) {
        
    }
}
