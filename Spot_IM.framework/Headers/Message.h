//
//  Message.h
//  Spot_IM
//
//  Created by Nissim Pardo on 28/12/2016.
//  Copyright © 2016 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef struct Ranks{
    NSInteger plus;
    NSInteger minus;
}Ranks;

@interface Message : NSObject
- (instancetype)initWithParams:(NSDictionary *)params;
@property (nonatomic, copy) NSString *messageId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSNumber *timeStamp;
@property (nonatomic) Ranks ranks;
@property (nonatomic, strong) User *user;
@end
