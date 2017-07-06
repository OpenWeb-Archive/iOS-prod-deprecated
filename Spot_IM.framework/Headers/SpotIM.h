//
//  SpotIM.h
//  Spot_IM
//
//  Created by Nissim Pardo on 01/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecirculationItem.h"
#import "Analytics.h"

@interface SpotIM : NSObject
+ (SpotIM *)shared;


- (void)recirculationId:(NSString *)recirculationId
             completion:(void(^)(NSArray<Item *> *items, NSError *error))completion;

@property (nonatomic, strong) Analytics *analytics;
@end
