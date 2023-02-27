//
//  LoaderImageView.swift
//  AppClipArMenu
//
//  Created by Влад Калаев on 20.06.2022.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

/**
 This class extends the ImageView to provide the additional feature for downloaidng the image from the Flickr server.
 */
class CustomImageView: UIImageView {
    
    /**
     The URL instance to download the image.
     */
    var imageURL:URL?
    
    //MARK: Public methods
    /**
     Downloads the image from the provided URL. Checks if the image is present in the cache, if found applies the image from the cache else downloads the image from the Flickr server.
     - Parameters:
        - URL: The URL string
     */
    internal func download(from URL: URL) {
        imageURL = URL
        image = nil
        if let cachedImage = imageCache.object(forKey: URL as AnyObject) as? UIImage {
            image = cachedImage
            return
        }
        URLSession.shared.dataTask(with: URL) {[weak self] data, response, error in
            guard
                let _ = self,
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let responseImage = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {[weak self] in
                
                guard let weakSelf = self else {
                    return
                }
                if weakSelf.imageURL == URL {
                    weakSelf.image = responseImage
                }
                imageCache.setObject(responseImage, forKey: URL as AnyObject)
            }
            }.resume()
    }
}

