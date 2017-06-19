//
//  SectionView.h
//  SpotQAApp
//
//  Created by Nissim Pardo on 19/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SectionView;
@protocol SectionViewDelegate <NSObject>

- (void)view:(SectionView *)view shouldPresentOptions:(NSArray *)options;

@end

@interface SectionView : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSArray *options;
@property (nonatomic, weak) id<SectionViewDelegate> delegate;
@end
