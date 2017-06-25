//
//  SwitchTableViewCell.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 25/06/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "SwitchTableViewCell.h"

@interface SwitchTableViewCell ()
@property (nonatomic, weak) IBOutlet UISwitch *ssoSwitch;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@end

@implementation SwitchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (BOOL)isEnabled {
    return _ssoSwitch.isOn;
}

- (IBAction)logToggle:(UIButton *)sender {
    sender.enabled = NO;
    [_delegate cell:self didChangeLoginState:_loggedIn];
}

- (void)setLoggedIn:(BOOL)loggedIn {
    _loginButton.enabled = YES;
    _loggedIn = loggedIn;
    [_loginButton setTitle:loggedIn ? @"Logout" : @"Login" forState:UIControlStateNormal];
}
@end
