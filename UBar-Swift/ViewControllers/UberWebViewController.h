//
//  UberWebViewController.h
//  UBarN
//
//  Created by Kertész Tibor on 15/10/15.
//  Copyright © 2015 CodingSans. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UberWebViewLoadType) {
    UberWebViewLoadTypeLogin,
    UberWebViewLoadTypeMap,
};

@interface UberWebViewController : UIViewController

@property (strong, nonatomic) NSString * URLStringToLoad;
@property (nonatomic) UberWebViewLoadType loadType;

@end
