//
//  NSString+Utilities.h
//  Spot_IM
//
//  Created by Nissim Pardo on 05/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Utilities)
@property (nonatomic, readonly, copy) NSArray *avatarParams;
@property (nonatomic, readonly, copy) NSURL *extractUrl;
@property (nonatomic, readonly, copy) NSDictionary *queryItems;
@end
