//
//  DiscradableImage.swift
//  SwiftyFastCache
//
//  Created by Javedmultani16 on 16/05/2019.
//  Copyright © 2019 Javedmultani16. All rights reserved.
//


import Foundation
import UIKit

open class DiscradableImage: NSObject, NSDiscardableContent {
    
    
    private(set) public var image : UIImage?
    var  accessedCounter : UInt = 0
    
    
    public init(image:UIImage) {
        
        self.image = image
    }
    
    
    public func beginContentAccess() -> Bool {
        
        if image == nil {
            
            return false
        }
        
        accessedCounter += 1
        return true
    }
    
    public func endContentAccess() {
        
        if accessedCounter > 0 {
            
            accessedCounter -= 1
        }
    }
    
    
    public func discardContentIfPossible() {
        
        if accessedCounter == 0 {
            
            image = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        
        return image == nil ? true : false
        
    }
    
}
