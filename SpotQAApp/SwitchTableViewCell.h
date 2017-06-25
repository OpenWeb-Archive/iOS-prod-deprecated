//
//  SwitchTableViewCell.h
//  SpotQAApp
//
//  Created by Nissim Pardo on 25/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchTableViewCell;
@protocol SwitchTableViewCellDelegate <NSObject>

- (void)cell:(SwitchTableViewCell *)cell didChangeLoginState:(BOOL)isLoggedIn;

@end

@interface SwitchTableViewCell : UITableViewCell
@property (nonatomic, readonly) BOOL isEnabled;
@property (nonatomic, getter=isLoggedIn) BOOL loggedIn;
@property (nonatomic, weak) id<SwitchTableViewCellDelegate> delegate;
@end
