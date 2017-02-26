//
//  StoreSearch.swift
//  SongBar
//
//  Created by Justin Oakes on 7/6/15.
//  Copyright (c) 2015 corpe. All rights reserved.
//

import Cocoa

class StoreSearch: NSObject {
    
    class func search(_ terms: String){
        var fullURL =  "\(kURLs.baseURL) \(terms)".replacingOccurrences(of: "-", with: "")
        fullURL = fullURL.replacingOccurrences(of: " ", with: "+")
        fullURL = fullURL.replacingOccurrences(of: "++", with: "+")
        
        let request: URLRequest = URLRequest(url: URL(string: fullURL)!)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data, responce, error) -> Void in
            if error != nil {
                print("\(error!)")
                return
            }
            let result: NSDictionary?

            do {
                let jsonObject = try data ?? JSONSerialization.data(withJSONObject: ["results" : []], options: JSONSerialization.WritingOptions.prettyPrinted)
                result = try JSONSerialization.jsonObject(with: jsonObject, options: JSONSerialization.ReadingOptions.mutableLeaves) as? NSDictionary
                
            } catch {
                print("\(error)")
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
                    var songURL: String = songDictionary["trackViewUrl"] as! String
                    songURL =  songURL.replacingOccurrences(of: "https://", with: "itms://")
                    NSWorkspace.shared().open(URL(string: "\(songURL)&app=itunes")!)
                })
            }
        })
        task.resume()
    }
    
    
}
