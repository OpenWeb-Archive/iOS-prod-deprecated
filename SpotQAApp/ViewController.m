//
//  ViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 23/01/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "ViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *spotIdTextField;
@property (weak, nonatomic) IBOutlet UISwitch *isRTL;
@property (strong, nonatomic) SpotIMController *spotController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)load:(UIButton *)sender {
    _spotController = [SpotIMController new];
    _spotController.view.frame = (CGRect){0, 100,self.view.frame.size.width, 496};
    _spotController.spotId = _spotIdTextField.text;
    _spotController.configuration.title = @"QA app";
    [self.view addSubview:_spotController.view];
    [_spotIdTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
