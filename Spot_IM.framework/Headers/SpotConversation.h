//
//  SpotConversation.h
//  Spot_IM
//
//  Created by Nissim Pardo on 29/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SpotConversation;
@protocol SSODelegate <NSObject>

- (void)spotConversation:(SpotConversation *)spotConversation didUpdateState:(BOOL)isLoggedIn;

@end

@interface SpotConversation : UIWebView
+ (SpotConversation *)shared;
@property (nonatomic, copy) NSString *spotId;
@property (nonatomic, copy) NSString *postId;
@property (nonatomic) BOOL shouldReload;
@property (nonatomic, strong) UIViewController *presentingController;
@property (nonatomic, readonly) BOOL isReady;
@property (nonatomic, readonly) BOOL isLoggedIn;
@property (nonatomic, weak) id<SSODelegate> ssoDelegate;

- (void)startSSOWithHandler:(void(^)(NSString *codeA, NSError *error))handler;
- (void)completeSSO:(NSString *)codeB completion:(void(^)(NSError *error))completion;
- (void)logoutSSOWithCompletion:(void(^)())completion;

- (void)dissmiss;
@end
