//
//  Configuration.h
//  Spot_IM
//
//  Created by Nissim Pardo on 31/12/2016.
//  Copyright © 2016 spot_im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"

@interface Configuration : NSObject
@property (nonatomic, copy) NSString *configId;
@property (nonatomic, strong) Network *network;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mainLanguage;
@property (nonatomic, copy) NSString *websiteUrl;
@property (nonatomic, copy) NSString *brandColor;
@property (nonatomic, copy) NSNumber *categoryId;
@property (nonatomic, copy) NSNumber *subCategoryId;
@property (nonatomic, copy) NSString *platform;
@property (nonatomic, copy) NSArray<NSString *> *languages;
@property (nonatomic, copy) NSArray<NSString *> *connectNetworks;
@property (nonatomic, copy) NSNumber *customLogin;
@property (nonatomic, copy) NSString *tickerIcon;
@property (nonatomic, copy) NSNumber *tickerIconSize;
@property (nonatomic, copy) NSString *tickerSkin;
@property (nonatomic, copy) NSString *newsfeedSkin;
@end
