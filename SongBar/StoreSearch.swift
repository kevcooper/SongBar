//
//  StoreSearch.swift
//  SongBar
//
//  Created by Justin Oakes on 7/6/15.
//  Copyright (c) 2015 corpe. All rights reserved.
//

import Cocoa

class StoreSearch: NSObject {
    
    static let sharedInstance: StoreSearch = StoreSearch()
    
    func search(terms: NSString){
        let baseURLString: String = "https://itunes.apple.com/search?term="
        var fullURL = "\(baseURLString)\(terms)".stringByReplacingOccurrencesOfString("-", withString: "", options: [], range: nil)
        fullURL = fullURL.stringByReplacingOccurrencesOfString(" ", withString: "+", options: [], range: nil)
        fullURL = fullURL.stringByReplacingOccurrencesOfString("++", withString: "+", options: [], range: nil)
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: fullURL)!)
        let session = NSURLSession.sharedSession()
        
           let task = session.dataTaskWithRequest(request, completionHandler: { (data, responce, error) -> Void in
            var songs: NSDictionary? = nil
            do {
             songs = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
            }catch{
                print(error)
            }
                if songs != nil {
                        let songArray: NSArray = songs?.objectForKey("results") as! NSArray
                    if songArray.count > 0 {
                        let songDictionary: NSDictionary = songArray[0] as! NSDictionary
                        var songURL: NSString = songDictionary["trackViewUrl"] as! NSString
                        songURL =  songURL.stringByReplacingOccurrencesOfString("https://", withString: "itms://")
                        print("\(songURL)")
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            NSWorkspace.sharedWorkspace().openURL(NSURL(string: "\(songURL)&app=itunes" as String)!)
                    })
                    }
                }
            })
        task.resume()
    }
    

}
