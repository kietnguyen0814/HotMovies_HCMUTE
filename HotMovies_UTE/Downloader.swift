//
//  Downloader.swift
//  HotMovies_UTE
//
//  Created by Duy Bùi on 6/4/17.
//  Copyright © 2017 Kiet Nguyen. All rights reserved.
//

import Foundation
import UIKit

class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
    
    class func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    class func downloadImage(url: URL){
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                //return UIImage(data: data)
            }
        }
    }
}
