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
@property (nonatomic) BOOL isPresented;
@end

@implementation ModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Conversation";
    [SpotConversation shared].frame = (CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0};
    [self.view addSubview:[SpotConversation shared]];
    [SpotConversation shared].postId = _postId;
    [SpotConversation shared].presentingController = self;
    [self.view addSubview:[SpotConversation shared]];
}


- (void)viewDidDisappear:(BOOL)animated {
    [[SpotConversation shared] dissmiss];
    [super viewDidDisappear:animated];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    if (_postId && [SpotConversation shared].shouldReload) {
//        [SpotConversation shared].frame = (CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64.0};
//        [self.view addSubview:[SpotConversation shared]];
//        [SpotConversation shared].postId = _postId;
//        [SpotConversation shared].presentingController = self;
//        [self.view addSubview:[SpotConversation shared]];
//    }
}

//- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
//    [[SpotConversation shared] dissmiss];
//    [super dismissViewControllerAnimated:flag completion:completion];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [SpotConversation shared].frame = [UIScreen mainScreen].bounds;
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
    
}

@end
