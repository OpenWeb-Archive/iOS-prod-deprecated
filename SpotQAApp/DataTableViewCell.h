//
//  DataTableViewCell.h
//  SpotQAApp
//
//  Created by Nissim Pardo on 19/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataTableViewCell : UITableViewCell
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, readonly, copy) NSString *text;
@end
