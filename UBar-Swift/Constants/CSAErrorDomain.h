//
//  CSAErrorDomain.h
//  UBar-Swift
//
//  Created by Kocsis Olivér on 2015. 10. 28..
//  Copyright © 2015. Bettina Hegedus. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *kCSAErrorDomain;
FOUNDATION_EXPORT NSString *kErrorResponseObjectKey;

typedef NS_ENUM(NSInteger, CSAErrorCode) {
    CSAErrorCodeUnknownError = 0,
    CSAErrorCodeResponseErrorMsg = 1,
    CSAErrorCodeResponseDataNil = 2,
    CSAErrorCodeResponseDataInvalid = 3,
    CSAErrorCodeInvalidJsonContainer = 4,
    CSAErrorCodeNetworkUnreachable = 5
};