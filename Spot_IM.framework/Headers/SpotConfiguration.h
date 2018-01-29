//
//  SpotConfiguration.h
//  Spot_IM
//
//  Created by Nissim Pardo on 11/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpotConfiguration : NSObject
@property (nonatomic) BOOL isRTL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic) float maxCacheSize;
@end
