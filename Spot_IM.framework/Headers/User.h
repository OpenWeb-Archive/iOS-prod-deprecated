//
//  User.h
//  Spot_IM
//
//  Created by Nissim Pardo on 28/12/2016.
//  Copyright © 2016 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
- (instancetype)initWithParams:(NSDictionary *)params;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSString *imageId;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSNumber *online;
@property (nonatomic, copy) NSNumber *points;
@end
