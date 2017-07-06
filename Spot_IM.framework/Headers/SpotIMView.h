//
//  SpotIMView.h
//  Spot_IM
//
//  Created by Nissim Pardo on 01/01/2017.
//  Copyright © 2017 spot_im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "AnalyticsType.h"

@protocol SpotIMViewDelegate <NSObject>

- (void)didSelectComment:(NSURL *)url messageId:(NSString *)messageId;

- (void)didSelectArticle:(NSURL *)url messageId:(NSString *)messageId;

@end

@interface SpotIMView : UIView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSArray<Item *> *items;
@property (nonatomic) BOOL isRTL;
@property (nonatomic, weak) id<SpotIMViewDelegate> delegate;
@end
