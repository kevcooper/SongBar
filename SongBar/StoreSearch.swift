//
//  StoreSearch.swift
//  SongBar
//
//  Created by Justin Oakes on 7/6/15.
//  Copyright (c) 2015 corpe. All rights reserved.
//

import Cocoa

class StoreSearch: NSObject {
    
    class func search(_ terms: NSString){
        let baseURLString: String = "https://itunes.apple.com/search?term="
        var fullURL =  "\(baseURLString) \(terms)".replacingOccurrences(of: "-", with: "")
        fullURL = fullURL.replacingOccurrences(of: " ", with: "+")
        fullURL = fullURL.replacingOccurrences(of: "++", with: "+")
        
        let request: URLRequest = URLRequest(url: URL(string: fullURL)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data, responce, error) -> Void in
            let result: NSDictionary?
            do {
                result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as? NSDictionary
                
            } catch {
                print("Failed to convert json data to NSDictonary")
                return
            }
            guard let songArray: NSArray = result?["results"] as? NSArray
                else {
                    print("failed to key \"result\" in result dictorary")
                    return
            }
            
            if songArray.count > 0 {
                DispatchQueue.main.async(execute: { () -> Void in
                    let songDictionary: NSDictionary = songArray[0] as! NSDictionary
                    var songURL: NSString = songDictionary["trackViewUrl"] as! NSString
                    songURL =  songURL.replacingOccurrences(of: "https://", with: "itms://") as NSString
                    print("\(songURL)")
                    NSWorkspace.shared().open(URL(string: "\(songURL)&app=itunes" as String)!)
                })
            }
        })
        task.resume()
    }
    
    
}
