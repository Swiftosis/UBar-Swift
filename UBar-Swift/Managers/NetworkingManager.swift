//
//  NetworkingManager.swift
//  UBar-Swift
//
//  Created by Kocsis Olivér on 2015. 10. 20..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

import UIKit
import AFNetworking
import CoreLocation



class NetworkingManager: NSObject {
    
    static let sharedInstance = NetworkingManager()
    
    let sessionManager: AFHTTPSessionManager
    
    
    override init() {
        self.sessionManager = AFHTTPSessionManager(baseURL: NSURL(string: kBaseUrlStr))
        self.sessionManager.requestSerializer = AFJSONRequestSerializer()
        self.sessionManager.responseSerializer = AFJSONResponseSerializer()
    }
    
    @objc func trySendLocation(coordinate coordinate: CLLocationCoordinate2D, onSuccess: (mapUrlStr:String) -> Void, onFailure: (error:NSError, statusCode:HTTPStatusCode ) -> Void ) {
        
        
        
        
        let reqData = [
            "position":
                [
                    "longitude": coordinate.longitude,
                    "latitude" : coordinate.latitude
            ]
        ]
        
        self.sessionManager.POST(kRequestEndPointStr, parameters: reqData,
            success: { (task, responseObj) -> Void in
                
                let statusCode:HTTPStatusCode
                if let response:NSHTTPURLResponse = task.response as? NSHTTPURLResponse {
                    statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? .Unknown
                } else {
                    statusCode = .Unknown
                }
                
                
                guard let responseDict = responseObj as? [String:AnyObject] else {
                    
                    let error = NSError(domain: kCSAErrorDomain, code: CSAErrorCode.ResponseDataInvalid.rawValue, userInfo: nil)
                    onFailure(error: error, statusCode: statusCode)
                    return
                }
                
                if let responseUrlStr = responseDict[kMapURLKey] as? String {
                    
                    onSuccess(mapUrlStr: responseUrlStr)
                    
                } else {
                    
                    let error = NSError(domain: kCSAErrorDomain, code: CSAErrorCode.ResponseDataInvalid.rawValue, userInfo: nil)
                    onFailure(error: error, statusCode: statusCode)
                }
                
            },
            failure: { (task, error) -> Void in
                let statusCode:HTTPStatusCode
                if let response:NSHTTPURLResponse = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey] as? NSHTTPURLResponse {
                    statusCode = HTTPStatusCode(rawValue: response.statusCode) ?? .Unknown
                } else {
                    statusCode = .Unknown
                }
                
                onFailure(error: error, statusCode: statusCode)
                
            }
        )
        
    }
    
    func checkLogin(onLoggedIn onLoggedIn: () -> Void, onNotLoggedIn: () -> Void, failure: (( NSError) -> Void)?) {
        
        self.sessionManager.GET(kCheckLoginEndPointStr, parameters: nil,
            success: { (task, responseObj) -> Void in
                
                guard let isLoggedIn = responseObj[kLoggedinKey] as? Bool else {
                    let error = NSError(domain: kCSAErrorDomain, code: CSAErrorCode.ResponseDataInvalid.rawValue, userInfo: nil)
                    if let failure = failure {
                        failure(error)
                    }
                    return
                }
                
                if isLoggedIn {
                    onLoggedIn()
                } else {
                    onNotLoggedIn()
                }
                
            },
            failure: { (task, error) -> Void in
                if let failure = failure {
                    failure(error)
                }
            }
        )
        
    }


}
