//
//  Analytics.h
//  Spot_IM
//
//  Created by Nissim Pardo on 28/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnalyticsType.h"


@interface Analytics : NSObject

- (instancetype)initWithSpotId:(NSString *)spotId;
@property (nonatomic) AnalyticsEventType eventType;
@property (nonatomic) NSInteger index;
@end
