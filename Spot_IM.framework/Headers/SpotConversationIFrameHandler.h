//
//  SpotConversationIFrameHandler.h
//  Spot_IM
//
//  Created by Nissim Pardo on 19/06/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpotConversationViewController.h"

@protocol ConversationIFrameDelegate <NSObject>

- (void)shouldLoadSpotConversation:(SpotConversationViewController *)controller;

@end

@interface SpotConversationIFrameHandler : NSObject
@property (nonatomic, weak) UIWebView *spotIFrameWebview;
@property (nonatomic, weak) id<ConversationIFrameDelegate> delegate;
@end
