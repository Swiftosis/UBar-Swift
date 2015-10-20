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


let kBaseUrlStr = "https://medivh.llwz.co";

let kRequestEndPointStr = "/api/v1/request";
let kAuthEndPointStr = "/api/v1/auth/uber";
let kCheckLoginEndPointStr = "/api/v1/checklogin";

let kTestURL = "https://codingsans.com";

let kMapURLKey = "map";
let kLoggedinKey = "loggedin";

let kReqRedirUrlStr = "https://uber.codingsans.com/";

let kIsTutorialLaunchedFirstTimeString = "isfirstlaunch";

class NetworkingManager: NSObject {
    
    let sessionManager: AFHTTPSessionManager
    
    
    override init() {
        self.sessionManager = AFHTTPSessionManager(baseURL: NSURL(string: kBaseUrlStr))
        self.sessionManager.requestSerializer = AFJSONRequestSerializer()
        self.sessionManager.responseSerializer = AFJSONResponseSerializer()
    }
    
    @objc func trySendLocation(coordinate coordinate: CLLocationCoordinate2D, onSuccess: (mapUrlStr:String) -> Void, onFailure: (error:NSError, statusCode:HTTPStatusCode ) -> Void ) {
        
        onFailure(error: NSError(domain: "", code: 999, userInfo: nil) ,statusCode: .Continue)
        onSuccess(mapUrlStr: "sfd")
    }

}
