//
//  ImageLoader.swift
//  MarvelSquads
//
//  Created by Magnus Holm on 03/09/2019.
//  Copyright © 2019 Magnus Holm. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

final class ImageLoader: UIImageView {
    
    // MARK: - Private properties
    
    private var imageURL: URL?
    private let activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Public methods
    
    func loadImage(with url: URL) {
        activityIndicator.color = .darkGray
        addSubview(activityIndicator)
        activityIndicator.anchor(centerX: centerXAnchor, centerY: centerYAnchor)
        
        imageURL = url
        image = nil
        activityIndicator.startAnimating()
        
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            activityIndicator.stopAnimating()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error as Any)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let unwrappedData = data, let imageToCache = UIImage(data: unwrappedData) {
                    if self.imageURL == url {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url as AnyObject)
                } else {
                    self.image = UIImage(named: "noImageAvailable")
                }
                self.activityIndicator.stopAnimating()
            })
        }).resume()
    }
}

