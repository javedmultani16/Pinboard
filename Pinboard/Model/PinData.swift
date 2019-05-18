//
//  PinData.swift
//  PinboardPins
//
//  Created by javedmultani16 on 17/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftyEasyCache

class PinData: NSObject {

    var userName:String?
    var name:String?
    var profileImageUrlString:String?
    var uploadedImageUrlString:String?
    var numberOfLikes:Int?
    var timeInfo:String?
    var imageHeight: CGFloat?

    var uploadedImage: UIImage? {
        get { return Constants.Caches.imageCache.unarchiveImage(url: uploadedImageUrlString) }
        
        set { Constants.Caches.imageCache.archiveImage(image: newValue, url: uploadedImageUrlString!)
            imageHeight = uploadedImage?.size.height
        }
    }
    
    var profileImage: UIImage? {
        get { return Constants.Caches.imageCache.unarchiveImage(url: profileImageUrlString) }
        
        set { Constants.Caches.imageCache.archiveImage(image: newValue, url: profileImageUrlString!) }
    }
    

    
    
    static func initPinData(_ pinDataJSON: JSON) -> PinData {
        let pinData = PinData()

        pinData.userName                   = pinDataJSON["user"]["username"].string
        pinData.name                       = pinDataJSON["user"]["name"].string
        pinData.profileImageUrlString      = pinDataJSON["user"]["profile_image"]["large"].string
        pinData.uploadedImageUrlString     = pinDataJSON["urls"]["thumb"].string
        pinData.numberOfLikes              = pinDataJSON["likes"].int
        pinData.timeInfo                   = pinDataJSON["created_at"].string
        
        pinData.imageHeight                = getImageHeight(urlString: pinData.uploadedImageUrlString!)
        
        return pinData
    }
    
    
    static func fetchPinData(_ callback: @escaping ([PinData], _ errorFlag: Bool) -> Void) {
        
        RestApiManager.sharedInstance.httpGETRequest(Constants.WebService.PinsListURL, callback:
            { (jsonDict) in
                
                if !jsonDict.arrayValue.isEmpty {
                    
                    var pinData = [PinData]()
                    let data = jsonDict.arrayValue
                    
                    for d in data {
                        let pins = PinData.initPinData(d)
                        pinData.append(pins)
                    }
                    
                    callback(pinData, false)
                    
                } else {
                    
                    callback([], true)
                }
        })
    }
    
    static func getImageHeight(urlString: String) -> CGFloat {
       
        let imageUrl = URL(string: urlString)
       
            
            let data = try? Data(contentsOf: imageUrl!)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                return (image?.size.height)!
            }
        return 5
            
//        let imageData = try? Data(contentsOf: imageUrl!)
//        let image = UIImage(data: imageData!)
//        let imageHeight = image?.size.height
//        return imageHeight!
        
    }
    
    
//    
//    required init?(json: JSON) {
//        
//        guard let userInfo              = json["user"] as? [String:AnyObject],
//            let profileImageInfo        = userInfo["profile_image"] as? [String:AnyObject],
//            let backgroundImageInfo     = json["urls"] as? [String:AnyObject] else {
//                return nil
//        }
//        
//        self.userName                   = userInfo["username"] as? String
//        self.profileImageUrlString      = profileImageInfo["small"] as? String
//        self.backgroundImageUrlString   = backgroundImageInfo["thumb"] as? String
//        self.numberOfLikes              = json["likes"] as? Int
//        self.timeInfo                   = json["created_at"] as? String
//        
//    }
//    
//    
//    static func fetchImageList(urlString: String, parameters: [String : AnyObject]?=nil, size:Int?=nil, completionHandler: @escaping Constants.CompletionHandler.apiResponse) {
//        
//        RestApiManager.sharedInstance.httpGETRequest(urlString, callback: { result in
//            print(result)
//            if result == JSON.null {
//                completionHandler(nil)
//            } else {
//                completionHandler(result)
//            }
//        })
//    }
//
//    
    
}
