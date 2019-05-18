//
//  Constants.swift
//  PinboardPins
//
//  Created by javedmultani16 on 17/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyEasyCache

class Constants: NSObject {
    
    struct WebService{
        
        static let PinboardBaseURL              =  "http://pastebin.com/"
        static let PinsListURL                  =  PinboardBaseURL + "raw/wgkJgazE"
    }
    
    
    struct Caches {
        static let imageCache                   = CacheManager(cacheCountLimit: 500, cacheSizeLimit: 500)
    }


    struct CompletionHandler{
        
        typealias PinDataCallback               = (_ result: [PinData], _ errorFlag:Bool) -> Void
        typealias apiResponse                   = (_ result: JSON) -> Void

    }

    
}


