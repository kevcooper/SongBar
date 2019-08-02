//
//  PlayerNotificationCenterListener.swift
//  SongBar
//
//  Created by Justin Oakes on 3/12/17.
//  Copyright © 2017 corpe. All rights reserved.
//

import Cocoa
class PlayerNotificationCenterListener {
    
    init() {
        DistributedNotificationCenter.default().addObserver(self,
                                                            selector: #selector(playbackStatusDidChange(notification:)),
                                                            name: .iTunesNotification,
                                                            object: nil)
        DistributedNotificationCenter.default().addObserver(self,
                                                            selector: #selector(playbackStatusDidChange(notification:)),
                                                            name: .spotifyNotification,
                                                            object: nil)
    }
    
    @objc func playbackStatusDidChange(notification: Notification) {
        guard let info: [AnyHashable : Any] = notification.userInfo else {
            return
        }
        let mediaController: MediaController = (NSApplication.shared.delegate as! AppDelegate).mediaController
        let sysBar: NSStatusItem = (NSApplication.shared.delegate as! AppDelegate).sysBar
        sysBar.updateStatusBar(itemTitle: mediaController.titleFrom(info: info))
    }
}
