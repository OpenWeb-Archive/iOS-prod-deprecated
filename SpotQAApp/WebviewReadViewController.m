//
//  WebviewReadViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 18/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "WebviewReadViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface WebviewReadViewController () <UIWebViewDelegate, ConversationIFrameDelegate>
@property (nonatomic, weak) IBOutlet UIWebView *webview;
@property (nonatomic, strong) SpotConversationIFrameHandler *handler;
@end

@implementation WebviewReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_demoPageLink.length) {
        NSString* host = @"https://www.spot.im";
        if (_isStaging) {
            host = @"https://stagingv2.spot.im";
        }
        _demoPageLink = [host stringByAppendingFormat:@"/modules/mobile-sdk/conversation/index.html?spot_id=%@&device=ios&message_count=4&post_id=%@", _spotId, _postId];
    }
    NSURL *url = [NSURL URLWithString:_demoPageLink];
    _handler = [SpotConversationIFrameHandler new];
    _handler.spotIFrameWebview = _webview;
    _handler.delegate = self;
    NSLog(@"iFrame - Loading the Following URL: %@", _demoPageLink);
    [_webview loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shouldLoadSpotConversation:(SpotConversationViewController *)controller {
    //TODO: Replace View Instead of Displaying Modally:
    [self presentViewController:controller animated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
