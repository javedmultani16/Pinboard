//
//  DiscardableJSON.swift
//  SwiftyFastCache
//
//  Created by Javedmultani16 on 16/05/2019.
//  Copyright © 2019 Javedmultani16. All rights reserved.
//
import Foundation

open class DiscardableJSON: NSObject, NSDiscardableContent {
    
    
    private(set) public var json : [String: AnyObject]?
    var  accessedCounter : UInt = 0
    
    
    public init(json:[String: AnyObject]) {
        
        self.json = json
    }
    
    
    public func beginContentAccess() -> Bool {
        
        if json == nil {
            
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
            
            json = nil
        }
    }
    
    public func isContentDiscarded() -> Bool {
        
        return json == nil ? true : false
        
    }
    
    
}
