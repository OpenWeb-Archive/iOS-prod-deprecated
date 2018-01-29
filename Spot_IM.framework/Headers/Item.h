//
//  Item.h
//  Spot_IM
//
//  Created by Nissim Pardo on 28/12/2016.
//  Copyright © 2016 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
#import "Extract.h"


@interface Item : NSObject
- (instancetype)initWithParams:(NSDictionary *)params;
@property (nonatomic, copy) NSString *postId;
@property (nonatomic, copy) NSString *conversationId;
@property (nonatomic, copy) NSNumber *messagesCount;
@property (nonatomic, strong) Message *message;
@property (nonatomic, strong) Extract *extract;
@property (nonatomic, copy) NSString *url;
@end
 
