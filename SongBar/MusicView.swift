//
//  MusicView.swift
//  SongBar
//
//  Created by Justin Oakes on 2/25/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Cocoa

class MusicView: NSView {

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.wantsLayer = true
        self.layer?.cornerRadius = 10.0
        self.layer?.backgroundColor = kColors.kBackgroundColor
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.cornerRadius = 10.0
        self.layer?.backgroundColor = kColors.kBackgroundColor
    }
}
