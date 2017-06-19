//
//  SectionView.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 19/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "SectionView.h"

@interface SectionView ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation SectionView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _button = [[NSBundle mainBundle] loadNibNamed:@"SectionView" owner:self options:nil].firstObject;
        _button.frame = self.bounds;
        [self addSubview:_button];
        return self;
    }
    return nil;
}

- (void)setText:(NSString *)text {
    _text = text;
    [_button setTitle:text forState:UIControlStateNormal];
}

- (IBAction)click:(id)sender {
    [_delegate view:self shouldPresentOptions:_options.copy];
}

@end
