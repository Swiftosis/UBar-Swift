//
//  UberWebViewController.m
//  UBarN
//
//  Created by Kertész Tibor on 15/10/15.
//  Copyright © 2015 CodingSans. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "NetworkingManager.h"
#import "NetworkingConstants.h"
#import "UberWebViewController.h"
#import "JGProgressHUD.h"

@interface UberWebViewController () <WKNavigationDelegate>

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic, readonly) WKWebView * webView;
@property (strong, nonatomic) NetworkingManager * networkingManager;
@property (strong,nonatomic) JGProgressHUD * HUD;

@end

@implementation UberWebViewController

@synthesize webView = _webView;
//webView getter
-(WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.containerView.frame configuration:[WKWebViewConfiguration new]];
        _webView.hidden = NO;
        _webView.frame = self.containerView.bounds;
        
        
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = NO;
        
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
        _webView.translatesAutoresizingMaskIntoConstraints = YES;
        
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        [self.containerView addSubview:_webView];
    }
    
    return _webView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.networkingManager = [NetworkingManager new];
    
    self.HUD = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    
    NSURLRequest * request = [NSURLRequest new];
    
    request = [self.networkingManager.sessionMan.requestSerializer requestWithMethod:@"GET"
                                                                 URLString:kTestURL
                                                                parameters:nil
                                                                     error:nil];

    if (self.loadType == UberWebViewLoadTypeLogin) {
        
        NSURL * baseURL = self.networkingManager.sessionMan.baseURL;
        
        NSURL * authURL = [baseURL URLByAppendingPathComponent:kAuthEndPointStr];
        
        NSDictionary * requestParameters = @{
                                             @"current" : kReqRedirUrlStr
                                             };
        
        request =
        [self.networkingManager.sessionMan.requestSerializer requestWithMethod:@"GET"
                                                                     URLString:authURL.absoluteString
                                                                    parameters:requestParameters
                                                                         error:nil];
        self.HUD.textLabel.text = @"Loading login page";
        
    } else if (self.loadType == UberWebViewLoadTypeMap){
        request =
        [self.networkingManager.sessionMan.requestSerializer requestWithMethod:@"GET"
                                                                     URLString:self.URLStringToLoad
                                                                    parameters:nil
                                                                        error:nil];
        self.HUD.textLabel.text = @"Loading Uber map page";
    }
    
    [self.webView loadRequest:request];
    [self.HUD showInView:self.view animated:YES];
    
}
     
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

/*
 This delegate called before every WKWebView navigation start. For eg. use it to evaulate an action based on the content of the navigation.
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL * url = navigationAction.request.URL;
    NSString * urlString = url.absoluteString;
    
    if ([urlString isEqualToString:kReqRedirUrlStr]) {
        NSLog(@"Redirected to the URL");
        
        decisionHandler(WKNavigationActionPolicyCancel);
        [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

/*
 This delegate called if some error was occoured during loading the webpage
 */
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:error.localizedDescription
                                                        delegate:self
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    [errorAlert show];
    
}
/*
 This delegate called if the WKWebView finished the navigation
 */
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.HUD dismissAnimated:YES];
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        //In progress
        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
