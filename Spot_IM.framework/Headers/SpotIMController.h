//
//  SpotIMController.h
//  Spot_IM
//
//  Created by Nissim Pardo on 01/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpotIMView.h"
#import "SpotConfiguration.h"

@class SpotIMController;

@protocol SpotIMControllerDelegate <SpotIMViewDelegate>

- (void)didLoadSpotIMController:(SpotIMController *)controller;

- (void)didFailLoadSpotIMController:(SpotIMController *)controller withError:(NSError *)error;

@end

@interface SpotIMController : NSObject
@property (nonatomic, copy) NSString *spotId;
@property (nonatomic, readonly) SpotIMView *view;
@property (nonatomic, strong) SpotConfiguration *configuration;
@property (nonatomic, weak) id<SpotIMControllerDelegate> delegate;
@end
