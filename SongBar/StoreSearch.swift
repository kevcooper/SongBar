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
        var fullURL = "\(baseURLString)\(terms)".stringByReplacingOccurrencesOfString("-", withString: "", options: nil, range: nil)
        fullURL = fullURL.stringByReplacingOccurrencesOfString(" ", withString: "+", options: nil, range: nil)
        fullURL = fullURL.stringByReplacingOccurrencesOfString("++", withString: "+", options: nil, range: nil)
        
        let request: NSURLRequest = NSURLRequest(URL: NSURL(string: fullURL)!)
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, responce, error) -> Void in
            var songs: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as! NSDictionary
            
            if songs.count > 0 {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    var songArray: NSArray = songs["results"] as! NSArray
                    var songDictionary: NSDictionary = songArray[0] as! NSDictionary
                    var songURL: NSString = songDictionary["trackViewUrl"] as! NSString
                    let version: NSString = self.getiTunesVersion()
                    songURL = version.containsString("12.2.0") ? songURL : songURL.stringByReplacingOccurrencesOfString("https://", withString: "itms://")
                    
                    NSWorkspace.sharedWorkspace().openURL(NSURL(string: songURL as String)!)
                })
            }
        })
       task.resume()
    }
    
    func getiTunesVersion()-> NSString {
        let iTunesPlistPath: String = "/Applications/iTunes.app/Contents/Info.plist"
        let plist: NSDictionary? = NSDictionary(contentsOfFile: iTunesPlistPath)
        return plist!["CFBundleGetInfoString"] as! NSString
    }

}
