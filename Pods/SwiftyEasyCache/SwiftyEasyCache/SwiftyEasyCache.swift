//
//  SwiftyEasyCache.swift
//  SwiftyEasyCache
//
//  Created by Javedmultani16 on 17/05/2019.
//  Copyright © 2019 Javedmultani16. All rights reserved.
//

import Foundation


public func download(url: NSURL) -> DownloadManager {
    
    return DownloadManager(url: url)
}


public func download(url: NSURL, shouldCache: Bool) -> DownloadManager {
    
    return DownloadManager(url: url, shouldCache: shouldCache)
}
