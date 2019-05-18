//
//  RestApiManager.swift
//  PinboardPins
//
//  Created by javedmultani16 on 15/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class RestApiManager: NSObject {
    
    
    static let sharedInstance: RestApiManager = { RestApiManager() }()
    
    
    static var managerInstance: Alamofire.SessionManager {
        struct Static {
            static var onceToken: Int = 0
            static var instance: Alamofire.SessionManager? = nil
        }
        
        let __once: () = {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 15 // seconds
            configuration.timeoutIntervalForResource = 15
            Static.instance = Alamofire.SessionManager(configuration: configuration)
        }()
        
        _ = __once
        
        return Static.instance!
        
    }
    
    static func httpGETRequest(_ path: String, parameters: AnyObject?=nil, callback: @escaping Constants.CompletionHandler.apiResponse) -> Void {
        
        let trimPath = path.trimmingCharacters(in: CharacterSet.whitespaces) + escapedParameters(parameters as! [String : AnyObject])
        print(trimPath)
        
        RestApiManager.managerInstance.request(trimPath, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            do{
                if let jsonData = response.data {
                    let json:JSON = try JSON(data: jsonData)
                    callback(json)
                } else {
                    callback(JSON.null)
                }
            }catch let err  as NSError{
                print(err)
            }
            
        }
    }
    
    
    func httpGETRequest(_ path: String, callback: @escaping Constants.CompletionHandler.apiResponse) -> Void {
        
        let trimPath = path.trimmingCharacters(in: CharacterSet.whitespaces)
        
        RestApiManager.managerInstance.request(trimPath, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            do{
            if let jsonData = response.data {
                let json:JSON = try JSON(data: jsonData)
                callback(json)
            } else {
                callback(JSON.null)
            }
            }catch let err as NSError {
                 print(err)
            }
        }
    }
    
    
    static func httpPOSTRequest(_ path: String, type: String = "", parameters: AnyObject?, callback: @escaping Constants.CompletionHandler.apiResponse) -> Void {
        
        let url = URL(string: path)
        var mutableURLRequest = URLRequest(url: url!)
        mutableURLRequest.httpMethod = "POST"
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if parameters != nil {
            mutableURLRequest.httpBody = parameters!.data(using: String.Encoding.utf8.rawValue)
        }
        
        RestApiManager.managerInstance.request(mutableURLRequest ).responseJSON { (response) in
            do {
            if let jsonData = response.data {
                let json:JSON = try JSON(data: jsonData)
                callback(json)
            } else {
                callback(JSON.null)
            }
        }catch let error as NSError {
            // error
        }
    }
    
        func cancelAllTask() {
        RestApiManager.managerInstance.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }
    }
    
    }
}
func escapedParameters(_ parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            let stringValue = "\(value)"
            let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            print(escapedValue)
            let replaceSpaceValue = stringValue.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil)
            
            urlVars += [key + "=" + "\(replaceSpaceValue)"]
        }
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joined(separator: "&")
    }

