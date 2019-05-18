//
//  CacheManager.swift
//  SwiftyFastCache
//
//  Created by Javedmultani16 on 16/05/2019.
//  Copyright © 2019 Javedmultani16. All rights reserved.
//

import Foundation
import UIKit

public class CacheManager {
    
    static public let sharedCache = CacheManager()
    
    let imageCache = NSCache<AnyObject, DiscradableImage>()
    let dataCache = NSCache<AnyObject, DiscardableData>()
    let jsonCache = NSCache<AnyObject, DiscardableJSON>()
    
    
    public init(cacheCountLimit: Int, cacheSizeLimit: Int) {
        
        imageCache.countLimit = cacheCountLimit
        dataCache.countLimit = cacheCountLimit
        jsonCache.countLimit = cacheCountLimit
        
        imageCache.totalCostLimit = cacheSizeLimit
        dataCache.totalCostLimit = cacheSizeLimit
        jsonCache.totalCostLimit = cacheSizeLimit
        
    }
    
    convenience init(){
        
        self.init(cacheCountLimit: 0,cacheSizeLimit: 0)
    }
    
    // Mark:- Cache Image
    
    public func archiveImage(image: UIImage?, url: String) {
        
        if image == nil {
            
            imageCache.removeObject(forKey: url as NSString)
            return
        }
        
        let data = DiscradableImage(image: image!)
        imageCache.setObject(data, forKey: url as NSString)
    }
    
    // Mark:- Cache Other Data like Json,Xml,etc
    
    public func archiveAnyData(any: AnyObject?, url: String) {
        
        if any == nil {
            
            dataCache.removeObject(forKey: url as NSString)
            return
        }
    
        
    }
    
    // Mark:- Retrive Data
    
    public func unarchiveData(url: String?) -> Data? {
        
        if url == nil || url! == "" {
            return nil
        }
        
        if let cachedData = dataCache.object(forKey: url! as NSString) {
            return cachedData.data
        }
        
        return nil
    }
    
    
    // Mark:- Retrive Json
    
    public func unarchiveJSON(url: String?) -> [String: AnyObject]? {
        
        if url == nil || url! == "" {
            return nil
        }
        
        if let cachedJSON = jsonCache.object(forKey: url! as NSString) {
            return cachedJSON.json
        }
        
        return nil
    }
    
    // Mark:- Retrive Image
    
    public func unarchiveImage(url: String?) -> UIImage? {
        
        if url == nil || url! == "" {
            return nil
        }
        
        if let cachedImage = imageCache.object(forKey: url! as NSString) {
            return cachedImage.image
        }
        
        return nil
    }
    
    // Mark:- Clear Cache
    
    public func clearCache() {
        
        imageCache.removeAllObjects()
        dataCache.removeAllObjects()
        jsonCache.removeAllObjects()
    }
    
}
