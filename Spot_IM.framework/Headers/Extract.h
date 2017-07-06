//
//  Extract.h
//  Spot_IM
//
//  Created by Nissim Pardo on 19/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Extract : NSObject
- (instancetype)initWithParams:(NSDictionary *)params;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageId;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *extractDescription;
@end
