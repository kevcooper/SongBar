//
//  MusicView.swift
//  SongBar
//
//  Created by Justin Oakes on 2/25/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Cocoa

class MusicView: NSView {

    @IBOutlet var view: MusicView!
    
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
        
        Bundle.main.loadNibNamed("MusicView", owner: self, topLevelObjects: nil)
        self.view.frame = NSRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        self.wantsLayer = true
        self.layer?.cornerRadius = 10.0
        self.layer?.backgroundColor = kColors.kBackgroundColor
        
        self.addSubview(self.view)
    }
    
    
    @IBAction func playClicked(_ sender: Any) {
    }

    
    @IBAction func ffClicked(_ sender: Any) {
    }
    
    @IBAction func rewindClicked(_ sender: Any) {
    }
    
}
