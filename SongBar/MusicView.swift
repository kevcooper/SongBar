////
////  MusicView.swift
////  SongBar
////
////  Created by Justin Oakes on 2/25/17.
////  Copyright © 2017 corpe. All rights reserved.
////
//
//import Cocoa
//
class MusicView: NSView {
    
    @IBOutlet var view: MusicView!
    @IBOutlet weak var playButton: NSButton?
    @IBOutlet weak var ffbutton: NSButton!
    @IBOutlet weak var rewindbutton: NSButton!
//    var initalized: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        wantsLayer = true
        layer?.cornerRadius = 10.0
        layer?.backgroundColor = kColors.kBackgroundColor
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        Bundle.main.loadNibNamed(NSNib.Name(rawValue: "MusicView"), owner: self, topLevelObjects: nil)
        view.frame = NSRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
        wantsLayer = true
        layer?.cornerRadius = 10.0
        layer?.backgroundColor = kColors.kBackgroundColor
        
        addSubview(view)
    }
    
    override func viewWillDraw() {
            let mediaController: MediaController = (NSApplication.shared.delegate as! AppDelegate).mediaController
            if let player: Player = mediaController.playingService() {
                let state: kPlaybackStates = mediaController.playbackState(player: player)
                setButtonForState(state: state)
            }
    }

    func setButtonForState(state: kPlaybackStates) {
        if let button: NSButton = playButton {
            switch state {
            case .paused:
                print("apuse")
                button.image = #imageLiteral(resourceName: "play")
                break
            case .playing:
                print("play")
                button.image = #imageLiteral(resourceName: "pause")
                break
            }
        }
    }
    
    @IBAction func playClicked(_ sender: Any) {
        let mediaController: MediaController = (NSApplication.shared.delegate as! AppDelegate).mediaController
        if let _: Player = mediaController.playingService() {
            mediaController.playPauseLastService()
            var state: kPlaybackStates = .paused
            if let player: Player = mediaController.playingService() {
                state = mediaController.playbackState(player: player)
            }
            setButtonForState(state: state)
        }
    }
    
    
    @IBAction func ffClicked(_ sender: Any) {
                let mediaController: MediaController = (NSApplication.shared.delegate as! AppDelegate).mediaController
                mediaController.playNext()
    }
    
    @IBAction func rewindClicked(_ sender: Any) {
                let mediaController: MediaController = (NSApplication.shared.delegate as! AppDelegate).mediaController
                mediaController.playPrevious()
    }
    
    @IBAction func downloadFromITS(_ sender: Any) {
                let appDeleagate: AppDelegate = (NSApplication.shared.delegate as! AppDelegate)
                if appDeleagate.sysBar.title != kMiscStrings.songbar && appDeleagate.sysBar.title != kMiscStrings.beats && appDeleagate.sysBar.title != nil {
                    StoreSearch.search(appDeleagate.sysBar.title!)
                }
    }
    
    @IBAction func displaySettings(_ sender: Any) {
        //        self.settingsWindow = self.settingsWindow ?? SettingsWindow(windowNibName: NSNib.Name(rawValue: kNIBNames.settingsWindow))
        //        self.settingsWindow?.showWindow(self)
        //        self.settingsWindow?.window?.orderFront(self)
    }
    
    @IBAction func closeApplication(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}

