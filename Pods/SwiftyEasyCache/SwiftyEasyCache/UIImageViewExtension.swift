//
//  UIImageViewExtension.swift
//  SwiftyFastCache
//
//  Created by Javedmultani16 on 16/05/2019.
//  Copyright © 2019 Javedmultani16. All rights reserved.
//

import Foundation
import UIKit


// Mark:- Image View Extension to check if image exsist in cache or not. If not then download it from server.
public extension UIImageView {
    
    
    func swifty_setImageWithUrl(url: NSURL, completion: @escaping (_ error : NSError?) -> Void) {
        
        self.swifty_setImageWithUrl(url: url, placeholderImage: nil, completion: completion)
    }
    
    
    func swifty_setImageWithUrl(url: NSURL) {
        
        self.swifty_setImageWithUrl(url: url, placeholderImage: nil, completion: nil)
    }
    
    
    func swifty_setImageWithUrl(url: NSURL, placeholderImage: UIImage? = nil, completion: ((_ error : NSError?) -> Void)?) {
        
        self.image = nil
        
        if let _ = placeholderImage {
            
            self.image = placeholderImage
        }
        
        if let cachedImage = CacheManager.sharedCache.unarchiveImage(url: url.absoluteString!) {
            
            self.image = cachedImage
            
            if let _ = completion {
                completion!(nil)
            }
            return
        }
        
        download(url: url).getImage { (url, image, error) -> Void in
            
            if error == nil , let _ = image {
                
                self.image = image!
                
                CacheManager.sharedCache.archiveImage(image: image!, url: url.absoluteString!)
                if let _ = completion {
                    completion!(nil)
                }
                
            } else {
                
                if let _ = completion {
                    completion!(error)
                }
            }
        }
    }
}
