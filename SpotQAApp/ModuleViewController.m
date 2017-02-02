//
//  ModuleViewController.m
//  SpotQAApp
//
//  Created by Nissim Pardo on 01/02/2017.
//  Copyright © 2017 spot. All rights reserved.
//

#import "ModuleViewController.h"
#import <Spot_IM/Spot_IM.h>

@interface ModuleViewController ()
@property (nonatomic, strong) SpotIMController *spotController;
@end

@implementation ModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_postId) {
        [SpotConversation shared].frame = (CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0};
        [self.view addSubview:[SpotConversation shared]];
        [SpotConversation shared].postId = _postId;
        [self.view addSubview:[SpotConversation shared]];
    } else {
        _spotController = [SpotIMController new];
        _spotController.view.frame = (CGRect){0, 0,  self.view.frame.size.width,  452};
        _spotController.spotId = _spotId;
        _spotController.configuration.title = @"QA";
        [self.view addSubview:_spotController.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
