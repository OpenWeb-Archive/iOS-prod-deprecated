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
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:@"http://localhost/SpotIMTest.html"];
    _handler = [SpotConversationIFrameHandler new];
    _handler.spotIFrameWebview = _webview;
    _handler.delegate = self;
    [_webview loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)shouldLoadSpotConversation:(SpotConversationViewController *)controller {
    [self presentViewController:controller animated:YES completion:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

@end
