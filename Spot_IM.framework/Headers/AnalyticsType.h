//
//  AnalyticsType.h
//  Spot_IM
//
//  Created by Nissim Pardo on 28/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger, AnalyticsEventType) {
    AnalyticsEventTypeViewed,
    AnalyticsEventTypeUnviewed,
    AnalyticsEventTypeClicked,
    AnalyticsEventTypeLoaded,
    AnalyticsEventTypeSwipedLeft,
    AnalyticsEventTypeSwipedRight
};


@interface AnalyticsType : NSObject
+ (NSString *)analyticsType:(AnalyticsEventType)type;
@end
