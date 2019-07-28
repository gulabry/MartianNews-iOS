//
//  ArticleAPI.swift
//  MartianNews
//
//  Created by Bryan Gula on 10/22/18.
//  Copyright © 2018 Gula, Inc. All rights reserved.
//

import Foundation
import UIKit

final class API {
    
    static var imageManager = ImageManager()
    
    static let contentURL = "http://mobile.public.ec2.nytimes.com.s3-website-us-east-1.amazonaws.com/candidates/content/v1/articles.plist"
    
    // Requests data from network then returns Article array in completion handler
    //
    static func get(completion: @escaping ([Article]?) -> Void) {
        let task = URLSession.shared.dataTask(with: URL(string: API.contentURL)!, completionHandler: { data, response, error in
            
            guard let responseData = data else { return completion(nil) }
            
            do {
                let articles = try PropertyListDecoder().decode([Article].self, from: responseData)
                completion(articles)
            } catch let err {
                print(err.localizedDescription)
                completion(nil)
            }
        })
        task.resume()
    }
}

final class ImageManager {
    
    var images: [URL: UIImage] = [:]
    
    func download(with url: URL, withCompletion completion: @escaping (UIImage?) -> Void) {
        
        // check if image was already downloaded
        //
        if images[url] == nil {
            
            URLSession.shared.dataTask(with : url, completionHandler: { data, response, error in
                guard let imageData = data else {
                    completion(nil)
                    return
                }
                
                let image = UIImage(data: imageData)
                
                // store image in current session dictionary
                //
                self.images[url] = image
                completion(image)

            }).resume()
            
        } else {
            
            print("Image Already Downloaded")
            completion(images[url])
        }
    }
}
