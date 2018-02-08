//
//  WebviewReadViewController.h
//  SpotQAApp
//
//  Created by Nissim Pardo on 18/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebviewReadViewController : UIViewController
@property (nonatomic, copy) NSString *demoPageLink;
@property (nonatomic) BOOL ssoEnabled;
@property (nonatomic, copy) NSString *spotId;
@property (nonatomic, copy) NSString *postId;
@property (nonatomic) BOOL isStaging;
@end
