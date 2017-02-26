//
//  ViewMenuItem.swift
//  SongBar
//
//  Created by Justin Oakes on 2/25/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Cocoa

class ViewMenuItem: NSMenuItem {
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.view?.wantsLayer = true
        
        let frame: NSRect = NSRect(x: 0, y: 0, width: 320.0, height: 95.0)
        
        let musicView = MusicView(frame: frame)
        self.view = musicView
    }
}
