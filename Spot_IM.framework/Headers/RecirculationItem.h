//
//  RecerculationItem.h
//  Spot_IM
//
//  Created by Nissim Pardo on 31/12/2016.
//  Copyright © 2016 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "Message.h"
#import "User.h"

@interface RecirculationItem : NSObject
- (instancetype)initWithItem:(Item *)item;
@property (nonatomic, strong) Item *item;
@property (nonatomic, strong) Message *message;
@property (nonatomic, strong) User *user;
@property (nonatomic) NSInteger index;
@end
