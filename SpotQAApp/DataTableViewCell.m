//
//  DataTableViewCell.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 19/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "DataTableViewCell.h"

@interface DataTableViewCell ()
@property (nonatomic, weak) IBOutlet UITextField *textField;
@end

@implementation DataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHint:(NSString *)hint {
    _textField.placeholder = hint;
}

- (void)setDefaultText:(NSString *)text {
    _textField.text = text;
}

- (NSString *)text {
    return _textField.text;
}
@end
